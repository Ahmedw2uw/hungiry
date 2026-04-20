import 'package:flutter/material.dart';
import 'package:hungry/core/constant/app_colors.dart';

class CustomUserTextFeald extends StatelessWidget {
  String lable;
  TextEditingController contrller;
   CustomUserTextFeald({super.key, required this.lable, required this.contrller  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
              controller: contrller,
              cursorColor: AppColors.bigtextColor,
              cursorHeight: 20,
              style: TextStyle(color: AppColors.bigtextColor),
              decoration: InputDecoration(
                labelText: lable,
                labelStyle: TextStyle(color: AppColors.bigtextColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: AppColors.bigtextColor,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: AppColors.bigtextColor,
                    width: 2,
                  ),
                ),
              ),
            );
  }
}