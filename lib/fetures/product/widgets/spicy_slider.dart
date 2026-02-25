import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/fetures/auth/views/shared/custom_text.dart';

class SpicySlider extends StatelessWidget {
  const SpicySlider({super.key, required this.value, required this.onChanged});
  final double value ;
  final ValueChanged <double> onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset("assets/products/throw.png", height: 250),
        Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            CustomText(
              text:
                  "Customize Your Burger\nto Your Tastes.\nUltimate Experience",
              size: 14,
            ),
            Gap(10),
            CustomText(text: "spicy"),
            Slider(
              value: value,
              min: 0,
              max: 1,
              onChanged: onChanged,
              activeColor: AppColors.primaryColor,
              inactiveColor: Colors.grey.shade300,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: "🥶"),
                Gap(90),
                CustomText(text: "🌶️"),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
