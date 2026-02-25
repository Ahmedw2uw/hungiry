import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/fetures/auth/views/shared/custom_button.dart';
import 'package:hungry/fetures/auth/views/shared/custom_text.dart';
import 'package:hungry/fetures/auth/views/shared/custom_text_feald.dart';

class LoginVeiw extends StatelessWidget {
  const LoginVeiw({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Gap(100),
                  SvgPicture.asset("assets/logo/Hungry_.svg"),
                  Gap(10),
                  CustomText(
                    text: "Welcome Back, Discover The Best Food",
                    color: AppColors.bigtextColor,
                    size: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  Gap(70),
                  CustomTextFeald(
                    hint: "Email",
                    isPassword: false,
                    controller: emailController,
                  ),
                  Gap(20),
                  CustomTextFeald(
                    hint: "Password",
                    isPassword: true,
                    controller: passwordController,
                  ),
                  Gap(30),
                  InkWell(
                    child: CustomButton(
                      text: "Login",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          print("looged in");
                        } else {
                          print("not looged in");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
