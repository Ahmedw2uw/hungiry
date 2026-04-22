import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/fetures/auth/data/auth_repo.dart';
import 'package:hungry/fetures/auth/views/shared/custom_button.dart';
import 'package:hungry/fetures/auth/views/shared/custom_snack_bar.dart';
import 'package:hungry/fetures/auth/views/shared/custom_text.dart';
import 'package:hungry/fetures/auth/views/shared/custom_text_feald.dart';
import 'package:hungry/fetures/auth/views/signup_view.dart';
import 'package:hungry/root.dart';

class LoginVeiw extends StatefulWidget {
  const LoginVeiw({super.key});

  @override
  State<LoginVeiw> createState() => _LoginVeiwState();
}

class _LoginVeiwState extends State<LoginVeiw> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthRepo authRepo = AuthRepo();
  bool isLoading = false;

  //! login function
  Future<void> login() async {
  FocusScope.of(context).unfocus();
  setState(() => isLoading = true);

  try {
    final user = await authRepo.login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

      if (!mounted) return;

    setState(() => isLoading = false);

    // الانتقال فوراً لصفحة الـ Root
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Root()),
    );

  } catch (e) {
    if (!mounted) return;
    setState(() => isLoading = false);

    String finalMessage = "حدث خطأ ما"; 

    if (e is ApiError) {
      finalMessage = e.message; 
    } else {
      finalMessage = "تأكد من اتصالك بالإنترنت أو صحة البيانات";
    }

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(customSnackBar(finalMessage));
  }
}

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },

      child: Scaffold(
        // الحل لمشكلة SnackBar: منع العناصر من التمدد خلف الكيبورد بشكل يسبب تداخل
        resizeToAvoidBottomInset: true,
        body: Center(
          child: Form(
            key: formKey,

            child: Column(
              children: [
                const Gap(120),

                SvgPicture.asset(
                  "assets/logo/Hungry_.svg",
                  color: AppColors.primaryColor,
                ),

                const Gap(10),

                CustomText(
                  text: "Welcome Back, Discover The Best Food",
                  size: 14,
                  fontWeight: FontWeight.w500,
                ),

                const Gap(120),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),

                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,

                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),

                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Gap(20),

                          CustomTextFeald(
                            hint: "Email",
                            isPassword: false,
                            controller: emailController,
                          ),

                          const Gap(20),

                          CustomTextFeald(
                            hint: "Password",
                            isPassword: true,
                            controller: passwordController,
                          ),

                          const Gap(30),
                          isLoading
                              ? CupertinoActivityIndicator(
                                  color: AppColors.bigtextColor,
                                )
                              : CustomButton(
                                  text: "Login",
                                  onTap: () {
                                    print("LOGIN PRESSED");

                                    if (formKey.currentState!.validate()) {
                                      print("VALID FORM");
                                      login();
                                    }
                                  },
                                ),

                          const Gap(12),

                          CustomButton(
                            text: "Create Account ?",
                            color: Colors.transparent,
                            textColor: AppColors.bigtextColor,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupView(),
                                ),
                              );
                            },
                          ),

                          const Gap(5),

                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Root()),
                              );
                            },

                            child: CustomText(
                              text: "Continue as guest",
                              color: AppColors.bigtextColor,
                            ),
                          ),
                        ],
                      ),
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
