import 'package:flutter/material.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/fetures/auth/views/shared/custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton( {super.key, required this.text, this.onTap});
  final String text;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
                    width: double.infinity,
                    height: 55,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.bigtextColor,
      
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CustomText(
                      text: text,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                      size: 18,
                    ),
                  ),
    );
  }
}