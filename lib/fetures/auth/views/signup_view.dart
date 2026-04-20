import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/fetures/auth/views/login_veiw.dart';
import 'package:hungry/fetures/auth/views/shared/custom_button.dart';
import 'package:hungry/fetures/auth/views/shared/custom_text.dart';
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
        // backgroundColor: AppColors.primaryColor,
        body: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Gap(130),
                SvgPicture.asset(
                  "assets/logo/Hungry_.svg",
                  color: AppColors.primaryColor,
                ),
                CustomText(text: "Welcome to Hungry"),
                Gap(60),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        Gap(20),
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
                        Gap(12),
                        CustomButton(
                          text: "Go to Login ?",
                          color: Colors.transparent,
                          textColor: AppColors.bigtextColor,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginVeiw(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
