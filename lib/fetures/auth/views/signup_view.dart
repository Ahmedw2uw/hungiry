import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/fetures/auth/views/shared/custom_button.dart';
import 'package:hungry/fetures/auth/views/shared/custom_text_feald.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _rePassController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Gap(100),
                  SvgPicture.asset("assets/logo/Hungry_.svg"),
                  Gap(60),
                  CustomTextFeald(
                    hint: "Name",
                    isPassword: false,
                    controller: _nameController,
                  ),
                  Gap(20),
                  CustomTextFeald(
                    hint: "Email",
                    isPassword: false,
                    controller: _emailController,
                  ),
                  Gap(20),
                  CustomTextFeald(
                    hint: "Password",
                    isPassword: true,
                    controller: _passwordController,
                  ),
                  Gap(20),
                  CustomTextFeald(
                    hint: "Re-Password",
                    isPassword: true,
                    controller: _rePassController,
                  ),
                  Gap(30),

                  CustomButton(
                    text: "Sign up",
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        print("success regester");
                      } else {
                        print("failed regester");
                      }
                    },
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
