import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/core/network/api_error.dart' show ApiError;
import 'package:hungry/fetures/auth/data/auth_repo.dart';
import 'package:hungry/fetures/auth/views/login_veiw.dart';
import 'package:hungry/fetures/auth/views/shared/custom_button.dart';
import 'package:hungry/fetures/auth/views/shared/custom_snack_bar.dart';
import 'package:hungry/fetures/auth/views/shared/custom_text.dart';
import 'package:hungry/fetures/auth/views/shared/custom_text_feald.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _rePassController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  AuthRepo authRepo = AuthRepo();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _rePassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> register() async {
    // إغلاق الكيبورد
    FocusManager.instance.primaryFocus?.unfocus();

    if (!formKey.currentState!.validate()) return;

    // تأكيد كلمة المرور
    if (_passwordController.text != _rePassController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar("Passwords do not match"),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final user = await authRepo.register(
        _emailController.text.trim(),
        _passwordController.text.trim(),
        _nameController.text.trim(),
      );

      if (!mounted) return;

      setState(() => isLoading = false);

      // 💡 نصيحة احترافية: بما أن المستخدم سجل بنجاح ومعنا التوكن، 
      // نرسله لصفحة الـ Root مباشرة ليدخل التطبيق فوراً
      if (user.token != null && user.token!.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginVeiw()),
        );
      } else {
        // إذا لم يوجد توكن، نرجعه للوجن
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginVeiw()),
        );
      }
      
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoading = false);

      String finalMessage = "حدث خطأ ما";
      if (e is ApiError) {
        finalMessage = e.message;
      } else {
        finalMessage = "تأكد من إدخال البيانات بشكل صحيح";
      }

      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(finalMessage));
    }
  }

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
                        Gap(20),
                        CustomTextFeald(
                          hint: "Confirm Password",
                          isPassword: true,
                          controller: _rePassController,
                        ),
                        Gap(30),

                        isLoading
                            ? CupertinoActivityIndicator(
                                color: AppColors.bigtextColor,
                              )
                            : CustomButton(text: "Sign up", onTap: register),
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
