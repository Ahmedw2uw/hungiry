import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/fetures/auth/views/shared/custom_text.dart';
import 'package:hungry/fetures/auth/views/shared/primary_custom_button.dart';

class CartItem extends StatelessWidget {
  CartItem({
    super.key,
    required this.image,
    required this.name,
    required this.description,
    required this.number,
    this.onRemove,
    this.onAdd,
    this.onRemoveCart,
  });
  String image, name, description;
  final int number;
  Function()? onRemove, onAdd, onRemoveCart;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.bigtextColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Image.asset(image, height: 110),

                Image.asset("assets/products/shadow.png"),
                CustomText(text: name, size: 18, fontWeight: FontWeight.bold),
                CustomText(text: description),

                Gap(10),
              ],
            ),

            Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: onRemove,
                      child: CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                        child: const Icon(Icons.remove, color: Colors.white),
                      ),
                    ),
                    Gap(20),
                    CustomText(
                      text: number.toString(),
                      size: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    Gap(20),
                    InkWell(
                      onTap: onAdd,
                      child: CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Gap(30),
                PrimaryCustomButton(text: "Remove", onTap: onRemoveCart),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
