import 'package:flutter/material.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/fetures/auth/views/shared/custom_text.dart';

class PrimaryCustomButton extends StatelessWidget {
  const PrimaryCustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.width = 160,
    this.height,
    this.color,
    this.icon,
  });

  final String text;
  final VoidCallback? onTap;
  final double width;
  final double? height;
  final Color? color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height ?? 55,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: color ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.bigtextColor, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: text,
              color: Colors.white,
              size: 18,
              fontWeight: FontWeight.bold,
            ),
            if (icon != null) ...[
              const SizedBox(width: 8),
              Expanded(child: Icon(icon, color: Colors.white, size: 20)),
            ],
          ],
        ),
      ),
    );
  }
}
