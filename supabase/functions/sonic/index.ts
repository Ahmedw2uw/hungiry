// ============================================================
// SONIC APP — Supabase Edge Functions
// File: supabase/functions/sonic/index.ts
//
// Deploy with: supabase functions deploy sonic
// All endpoints live under one function using URL routing.
// ============================================================

import { serve } from "https://deno.land/std@0.177.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const SUPABASE_URL = Deno.env.get("PROJECT_URL")!;
const SUPABASE_ANON_KEY = Deno.env.get("PROJECT_ANON_KEY")!;
const SUPABASE_SERVICE_KEY = Deno.env.get("PROJECT_SERVICE_KEY")!;

const cors = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, content-type",
};

function json(data: unknown, status = 200) {
  return new Response(JSON.stringify(data), {
    status,
    headers: { ...cors, "Content-Type": "application/json" },
  });
}

// Build a client that carries the user's JWT so RLS applies
function userClient(req: Request) {
  const token = req.headers.get("authorization")?.replace("Bearer ", "");
  return createClient(SUPABASE_URL, SUPABASE_ANON_KEY, {
    global: { headers: { Authorization: `Bearer ${token}` } },
  });
}

// Admin client bypasses RLS (use carefully)
const adminClient = createClient(SUPABASE_URL, SUPABASE_SERVICE_KEY);

// ─────────────────────────────────────────────
// ROUTER
// ─────────────────────────────────────────────
serve(async (req: Request) => {
  if (req.method === "OPTIONS") return new Response(null, { headers: cors });

  const url = new URL(req.url);
  // Strip the function prefix  e.g. /sonic/profile → /profile
  const path = url.pathname.replace(/^\/sonic/, "") || "/";
  const method = req.method;

  try {
    // ── AUTH ─────────────────────────────────────────────────

    // POST /register
    if (path === "/register" && method === "POST") {
      const form = await req.formData();
      const email    = form.get("email") as string;
      const password = form.get("password") as string;
      const name     = form.get("name") as string;
      const phone    = form.get("phone") as string;

      const { data, error } = await adminClient.auth.admin.createUser({
        email, password, email_confirm: true,
      });
      if (error) return json({ error: error.message }, 400);

      await adminClient.from("profiles").update({ name, phone }).eq("id", data.user.id);

      return json({ message: "Registered successfully", data: { id: data.user.id, email } }, 201);
    }

    // POST /login
    if (path === "/login" && method === "POST") {
      const body = await req.json();
      const { data, error } = await adminClient.auth.signInWithPassword({
        email: body.email,
        password: body.password,
      });
      if (error) return json({ error: error.message }, 401);
      return json({ data: { token: data.session?.access_token, user: data.user } });
    }

    // POST /logout
    if (path === "/logout" && method === "POST") {
      const client = userClient(req);
      const { error } = await client.auth.signOut();
      if (error) return json({ error: error.message }, 400);
      return json({ message: "Logged out successfully" });
    }

    // GET /profile
    if (path === "/profile" && method === "GET") {
      const client = userClient(req);
      const { data: { user }, error: authErr } = await client.auth.getUser();
      if (authErr || !user) return json({ error: "Unauthorized" }, 401);

      const { data, error } = await client
        .from("profiles").select("*").eq("id", user.id).single();
      if (error) return json({ error: error.message }, 400);
      return json({ data });
    }

    // POST /update-profile
    if (path === "/update-profile" && method === "POST") {
      const client = userClient(req);
      const { data: { user }, error: authErr } = await client.auth.getUser();
      if (authErr || !user) return json({ error: "Unauthorized" }, 401);

      // Accepts JSON or form-data
      let updates: Record<string, unknown> = {};
      const ct = req.headers.get("content-type") ?? "";
      if (ct.includes("multipart/form-data")) {
        const form = await req.formData();
        if (form.get("name"))    updates.name    = form.get("name");
        if (form.get("email"))   updates.email   = form.get("email");
        if (form.get("phone"))   updates.phone   = form.get("phone");
        if (form.get("address")) updates.address = form.get("address");
        // image upload: store in Supabase Storage and save URL
        const img = form.get("image") as File | null;
        if (img) {
          const ext  = img.name.split(".").pop();
          const path = `avatars/${user.id}.${ext}`;
          await adminClient.storage.from("avatars").upload(path, img, { upsert: true });
          const { data: urlData } = adminClient.storage.from("avatars").getPublicUrl(path);
          updates.image_url = urlData.publicUrl;
        }
      } else {
        updates = await req.json();
      }

      const { data, error } = await client.from("profiles")
        .update(updates).eq("id", user.id).select().single();
      if (error) return json({ error: error.message }, 400);
      return json({ data });
    }

    // ── CATEGORIES ───────────────────────────────────────────

    // GET /categories
    if (path === "/categories" && method === "GET") {
      const { data, error } = await adminClient.from("categories").select("*");
      if (error) return json({ error: error.message }, 400);
      return json({ data });
    }

    // ── PRODUCTS ─────────────────────────────────────────────

    // GET /products  ?name=Burger  &category_id=1
    if (path === "/products" && method === "GET") {
      const client = userClient(req);
      const { data: { user }, error: authErr } = await client.auth.getUser();
      if (authErr || !user) return json({ error: "Unauthorized" }, 401);

      let query = adminClient
        .from("products")
        .select("*, categories(id, name)")
        .eq("is_available", true);

      const name = url.searchParams.get("name");
      const catId = url.searchParams.get("category_id");
      if (name)  query = query.ilike("name", `%${name}%`);
      if (catId) query = query.eq("category_id", parseInt(catId));

      const { data, error } = await query;
      if (error) return json({ error: error.message }, 400);
      return json({ data });
    }

    // GET /products/:id
    const productMatch = path.match(/^\/products\/(\d+)$/);
    if (productMatch && method === "GET") {
      const client = userClient(req);
      const { data: { user }, error: authErr } = await client.auth.getUser();
      if (authErr || !user) return json({ error: "Unauthorized" }, 401);

      const { data, error } = await adminClient
        .from("products")
        .select("*, categories(id, name)")
        .eq("id", parseInt(productMatch[1]))
        .single();
      if (error) return json({ error: error.message }, 404);
      return json({ data });
    }

    // ── FAVORITES ────────────────────────────────────────────

    // POST /toggle-favorite  { product_id }
    if (path === "/toggle-favorite" && method === "POST") {
      const client = userClient(req);
      const { data: { user }, error: authErr } = await client.auth.getUser();
      if (authErr || !user) return json({ error: "Unauthorized" }, 401);

      const { product_id } = await req.json();
      const existing = await adminClient.from("favorites")
        .select("id").eq("user_id", user.id).eq("product_id", product_id).maybeSingle();

      if (existing.data) {
        await adminClient.from("favorites").delete().eq("id", existing.data.id);
        return json({ message: "Removed from favorites" });
      }
      await adminClient.from("favorites").insert({ user_id: user.id, product_id });
      return json({ message: "Added to favorites" });
    }

    // GET /favorites
    if (path === "/favorites" && method === "GET") {
      const client = userClient(req);
      const { data: { user }, error: authErr } = await client.auth.getUser();
      if (authErr || !user) return json({ error: "Unauthorized" }, 401);

      const { data, error } = await adminClient
        .from("favorites")
        .select("*, products(id, name, price, image_url)")
        .eq("user_id", user.id);
      if (error) return json({ error: error.message }, 400);
      return json({ data });
    }

    // ── PRODUCT OPTIONS ──────────────────────────────────────

    // GET /toppings
    if (path === "/toppings" && method === "GET") {
      const client = userClient(req);
      const { error: authErr } = await client.auth.getUser();
      if (authErr) return json({ error: "Unauthorized" }, 401);

      const { data, error } = await adminClient.from("toppings").select("*");
      if (error) return json({ error: error.message }, 400);
      return json({ data });
    }

    // GET /side-options
    if (path === "/side-options" && method === "GET") {
      const client = userClient(req);
      const { error: authErr } = await client.auth.getUser();
      if (authErr) return json({ error: "Unauthorized" }, 401);

      const { data, error } = await adminClient.from("side_options").select("*");
      if (error) return json({ error: error.message }, 400);
      return json({ data });
    }

    // ── ORDERS ───────────────────────────────────────────────

    // POST /orders  { items: [{ product_id, quantity, spicy, toppings[], side_options[] }] }
    if (path === "/orders" && method === "POST") {
      const client = userClient(req);
      const { data: { user }, error: authErr } = await client.auth.getUser();
      if (authErr || !user) return json({ error: "Unauthorized" }, 401);

      const { items } = await req.json();

      // Calculate total price
      let totalPrice = 0;
      for (const item of items) {
        const { data: product } = await adminClient
          .from("products").select("price").eq("id", item.product_id).single();
        if (product) totalPrice += product.price * item.quantity;

        for (const tid of (item.toppings ?? [])) {
          const { data: t } = await adminClient.from("toppings").select("price").eq("id", tid).single();
          if (t) totalPrice += t.price * item.quantity;
        }
        for (const sid of (item.side_options ?? [])) {
          const { data: s } = await adminClient.from("side_options").select("price").eq("id", sid).single();
          if (s) totalPrice += s.price * item.quantity;
        }
      }

      // Insert order
      const { data: order, error: orderErr } = await adminClient
        .from("orders").insert({ user_id: user.id, total_price: totalPrice }).select().single();
      if (orderErr) return json({ error: orderErr.message }, 400);

      // Insert order items + pivot rows
      for (const item of items) {
        const { data: product } = await adminClient
          .from("products").select("price").eq("id", item.product_id).single();

        const { data: oi } = await adminClient.from("order_items").insert({
          order_id:   order.id,
          product_id: item.product_id,
          quantity:   item.quantity,
          spicy:      item.spicy ?? 0,
          unit_price: product?.price ?? 0,
        }).select().single();

        if (oi) {
          if (item.toppings?.length) {
            await adminClient.from("order_item_toppings").insert(
              item.toppings.map((tid: number) => ({ order_item_id: oi.id, topping_id: tid }))
            );
          }
          if (item.side_options?.length) {
            await adminClient.from("order_item_side_options").insert(
              item.side_options.map((sid: number) => ({ order_item_id: oi.id, side_option_id: sid }))
            );
          }
        }
      }

      return json({ message: "Order placed successfully", data: { order_id: order.id, total_price: totalPrice } }, 201);
    }

    // GET /orders
    if (path === "/orders" && method === "GET") {
      const client = userClient(req);
      const { data: { user }, error: authErr } = await client.auth.getUser();
      if (authErr || !user) return json({ error: "Unauthorized" }, 401);

      const { data, error } = await adminClient
        .from("orders")
        .select("id, total_price, status, created_at")
        .eq("user_id", user.id)
        .order("created_at", { ascending: false });
      if (error) return json({ error: error.message }, 400);
      return json({ data });
    }

    // GET /orders/:id
    const orderMatch = path.match(/^\/orders\/(\d+)$/);
    if (orderMatch && method === "GET") {
      const client = userClient(req);
      const { data: { user }, error: authErr } = await client.auth.getUser();
      if (authErr || !user) return json({ error: "Unauthorized" }, 401);

      const { data: order, error } = await adminClient
        .from("orders")
        .select(`
          id, total_price, status, created_at,
          order_items (
            id, quantity, spicy, unit_price,
            products (id, name, image_url),
            order_item_toppings ( toppings (id, name, price) ),
            order_item_side_options ( side_options (id, name, price) )
          )
        `)
        .eq("id", parseInt(orderMatch[1]))
        .eq("user_id", user.id)
        .single();

      if (error) return json({ error: error.message }, 404);
      return json({ data: order });
    }

    // ── CART ─────────────────────────────────────────────────

    // POST /cart/add  { items: [...] }
    if (path === "/cart/add" && method === "POST") {
      const client = userClient(req);
      const { data: { user }, error: authErr } = await client.auth.getUser();
      if (authErr || !user) return json({ error: "Unauthorized" }, 401);

      const { items } = await req.json();
      const added = [];

      for (const item of items) {
        const { data: ci } = await adminClient.from("cart_items").insert({
          user_id:    user.id,
          product_id: item.product_id,
          quantity:   item.quantity,
          spicy:      item.spicy ?? 0,
        }).select().single();

        if (ci) {
          if (item.toppings?.length) {
            await adminClient.from("cart_item_toppings").insert(
              item.toppings.map((tid: number) => ({ cart_item_id: ci.id, topping_id: tid }))
            );
          }
          if (item.side_options?.length) {
            await adminClient.from("cart_item_side_options").insert(
              item.side_options.map((sid: number) => ({ cart_item_id: ci.id, side_option_id: sid }))
            );
          }
          added.push(ci.id);
        }
      }

      return json({ message: "Items added to cart", data: { cart_item_ids: added } }, 201);
    }

    // GET /cart
    if (path === "/cart" && method === "GET") {
      const client = userClient(req);
      const { data: { user }, error: authErr } = await client.auth.getUser();
      if (authErr || !user) return json({ error: "Unauthorized" }, 401);

      const { data, error } = await adminClient
        .from("cart_items")
        .select(`
          id, quantity, spicy, created_at,
          products (id, name, price, image_url),
          cart_item_toppings ( toppings (id, name, price) ),
          cart_item_side_options ( side_options (id, name, price) )
        `)
        .eq("user_id", user.id);
      if (error) return json({ error: error.message }, 400);
      return json({ data });
    }

    // DELETE /cart/remove/:id
    const cartMatch = path.match(/^\/cart\/remove\/(\d+)$/);
    if (cartMatch && method === "DELETE") {
      const client = userClient(req);
      const { data: { user }, error: authErr } = await client.auth.getUser();
      if (authErr || !user) return json({ error: "Unauthorized" }, 401);

      const { error } = await adminClient
        .from("cart_items")
        .delete()
        .eq("id", parseInt(cartMatch[1]))
        .eq("user_id", user.id);

      if (error) return json({ error: error.message }, 400);
      return json({ message: "Item removed from cart" });
    }

    // ─────────────────────────────────────────────────────────
    return json({ error: "Not found" }, 404);
  } catch (err) {
    return json({ error: String(err) }, 500);
  }
});