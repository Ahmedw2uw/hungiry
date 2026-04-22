import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/fetures/auth/data/auth_repo.dart';
import 'package:hungry/fetures/auth/data/user_model.dart';
import 'package:hungry/fetures/auth/views/login_veiw.dart';
import 'package:hungry/fetures/auth/views/shared/custom_text.dart';
import 'package:hungry/fetures/auth/views/shared/primary_custom_button.dart';
import 'package:hungry/fetures/auth/widgets/custom_user_text_feald.dart';

class ProfileVeiw extends StatefulWidget {
  const ProfileVeiw({super.key});

  @override
  State<ProfileVeiw> createState() => _ProfileVeiwState();
}

class _ProfileVeiwState extends State<ProfileVeiw> {
  final AuthRepo authRepo = AuthRepo(); // إضافة الريبو
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController address = TextEditingController();

  bool isLoading = false; // لإدارة حالة التحميل

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // جلب البيانات الحقيقية عند الدخول
  }

  // دالة جلب البيانات من السيرفر
  Future<void> _fetchUserData() async {
    try {
      UserModel user = await authRepo.getUserData();
      setState(() {
        name.text = user.name;
        email.text = user.email;
        address.text = user.address ?? "";
      });
    } catch (e) {
      print("Error fetching profile: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0.0,
        leading: Icon(Icons.arrow_back, color: AppColors.bigtextColor),
        actions: [
          Icon(Icons.settings, color: AppColors.bigtextColor),
          const SizedBox(width: 15),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.bigtextColor, width: 2),
                    image: const DecorationImage(
                      image: AssetImage("assets/profile/profile_img.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const Gap(35),
              CustomUserTextFeald(lable: "Name", contrller: name),
              const Gap(25),
              CustomUserTextFeald(lable: "Email", contrller: email),
              const Gap(25),
              CustomUserTextFeald(lable: "Address", contrller: address),
              const Gap(25),
              CustomUserTextFeald(
                lable: "Password",
                contrller: TextEditingController(text: "********"),
              ), // حقل كلمة المرور
              const Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(color: AppColors.bigtextColor, thickness: 1),
              ),
              const Gap(20),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                tileColor: Colors.grey.shade300,
                leading: Image.asset(
                  "assets/doler_icon/visa.png",
                  width: 50,
                  color: Colors.blueAccent,
                ),
                title: CustomText(
                  text: "Debit card",
                  color: AppColors.medumetextcolor,
                  fontWeight: FontWeight.bold,
                  size: 15,
                ),
                subtitle: CustomText(
                  text: "**** *****12",
                  color: AppColors.medumetextcolor,
                ),
                trailing: CustomText(
                  text: "default",
                  color: AppColors.primaryColor,
                  size: 12,
                ),
                onTap: () {},
              ),
              const Gap(100),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 80,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.bigtextColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.smalltextcolor,
              blurRadius: 15,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          children: [
            PrimaryCustomButton(
              text: isLoading
                  ? "Saving..."
                  : "Edit Profile", // تغيير النص أثناء التحميل
              onTap: () async {
                setState(() => isLoading = true);
                try {
                  await authRepo.updateUser(name.text, email.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Profile Updated!")),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Update Failed")),
                  );
                } finally {
                  setState(() => isLoading = false);
                }
              },
              icon: Icons.edit,
              width: 170,
              color: AppColors.primaryColor,
            ),
            const Spacer(),
            PrimaryCustomButton(
              text: "Log Out",
              color: AppColors.primaryColor,
              onTap: () async {
                await authRepo
                    .logout(); // تنفيذ تسجيل الخروج من السيرفر ومسح التوكن
                if (!mounted) return;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginVeiw()),
                );
              },
              icon: Icons.logout,
            ),
          ],
        ),
      ),
    );
  }
}
