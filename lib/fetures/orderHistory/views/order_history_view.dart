import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/fetures/auth/views/shared/custom_button.dart';
import 'package:hungry/fetures/auth/views/shared/custom_text.dart';
import 'package:hungry/fetures/auth/views/shared/primary_custom_button.dart';
import 'package:hungry/fetures/cart/widgets/cart_item.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.bigtextColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 110, top: 10),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Card(
              color: AppColors.bigtextColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 25,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset("assets/products/h.png", height: 110),
                        Gap(10),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Hamburger ",
                              size: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomText(text: "Veggie Burger"),
                            Gap(10),
                            CustomText(text: "quantity: 2"),
                            Gap(10),
                            CustomText(text: "Total: \$200"),
                            Gap(10),
                            CustomText(text: "Date: 12/12/2023"),
                          ],
                        ),
                      ],
                    ),

                    Gap(20),
                    PrimaryCustomButton(
                      text: "Reorder",
                      onTap: () {
                        
                      },
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
