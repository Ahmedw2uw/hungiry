import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/fetures/auth/views/shared/custom_text.dart';
import 'package:hungry/fetures/auth/views/shared/primary_custom_button.dart';
import 'package:hungry/fetures/cart/widgets/cart_item.dart';
import 'package:hungry/fetures/checkout/views/chickout_view.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  int itemCount = 10;
  late List<int> quantity;
  @override
  void initState() {
    quantity = List.generate(itemCount, (index) => 1);
    super.initState();
  }

  void increment(index) {
    setState(() {
      quantity[index]++;
    });
  }

  void decrement(index) {
    setState(() {
      if (quantity[index] > 1) {
        quantity[index]--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.bigtextColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 110, top: 20),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return CartItem(
              image: "assets/products/h.png",
              name: "Hamburger ",
              description: "Veggie Burger",
              number: quantity[index],
              onRemove: () {
                decrement(index);
              },
              onAdd: () {
                increment(index);
              },
              onRemoveCart: () {},
            );
          },
        ),
      ),

      bottomSheet: Container(
        height: 90,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.bigtextColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.smalltextcolor,
              blurRadius: 15,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          children: [
            Column(
              children: [
                CustomText(
                  text: "Total ",
                  size: 16,
                  fontWeight: FontWeight.bold,
                ),
                Gap(10),
                CustomText(text: "\$ 12.99", size: 24),
              ],
            ),
            Spacer(),
            PrimaryCustomButton(
              text: "Chickout",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ChickoutView()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
