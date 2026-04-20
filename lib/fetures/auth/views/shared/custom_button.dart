import 'package:flutter/material.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/fetures/auth/views/shared/custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.color,
    this.textColor,
  });
  final String text;
  final Function()? onTap;
  final Color? color;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 55,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color ?? AppColors.bigtextColor,
          border: Border.all(color: AppColors.bigtextColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: CustomText(
          text: text,

          color: textColor ?? AppColors.primaryColor,
          fontWeight: FontWeight.w600,
          size: 18,
        ),
      ),
    );
  }
}
