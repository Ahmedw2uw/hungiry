import 'package:flutter/material.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/fetures/auth/views/shared/custom_text.dart';

class PrimaryCustomButton extends StatelessWidget {
  PrimaryCustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.width = 160,
    this.height,
  });
  final String text;
  final Function()? onTap;
  late double width;
  double? height;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height ?? 55,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: CustomText(
            text: text,
            color: Colors.white,
            size: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
