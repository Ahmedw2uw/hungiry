import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/fetures/auth/views/shared/custom_text.dart';
import 'package:hungry/fetures/auth/views/shared/primary_custom_button.dart';
import 'package:hungry/fetures/checkout/views/chickout_view.dart';
import 'package:hungry/fetures/product/widgets/spicy_slider.dart';
import 'package:hungry/fetures/product/widgets/toping_card.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  double spicyValue = 0.3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpicySlider(
                value: spicyValue,
                onChanged: (value) {
                  setState(() {
                    spicyValue = value;
                  });
                },
              ),

              Gap(50),
              CustomText(
                text: "Topings",
                size: 25,
                fontWeight: FontWeight.bold,
              ),
              Gap(20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(6, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: TopingCard(
                        title: "Tomatos",
                        image: "assets/products/tomato.png",
                        onAdd: () {},
                      ),
                    );
                  }),
                ),
              ),
              Gap(20),
              CustomText(
                text: "Side Options",
                size: 25,
                fontWeight: FontWeight.bold,
              ),
              Gap(40),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(6, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: TopingCard(
                        title: "Tomatos",
                        image: "assets/products/tomato.png",
                        onAdd: () {},
                      ),
                    );
                  }),
                ),
              ),

              Gap(200),
            ],
          ),
        ),
      ),

      bottomSheet: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.smalltextcolor,
              blurRadius: 15,
              offset: Offset(0, 0),
            ),
          ],
        ),
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Column(
                children: [
                  CustomText(
                    text: "Total ",
                    size: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  Gap(10),
                  CustomText(text: "\$ 12.99", size: 30),
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
      ),
    );
  }
}
