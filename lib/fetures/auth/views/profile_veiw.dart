import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
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
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController address = TextEditingController();

  @override
  void initState() {
    name.text = "John Doe";
    email.text = "john.doe@example.com";
    address.text = "123 Main Street, City, Country";
    super.initState();
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
          SizedBox(width: 15),
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
                    image: DecorationImage(
                      image: const AssetImage("assets/profile/profile_img.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Gap(35),

              CustomUserTextFeald(lable: "Name", contrller: name),
              Gap(25),
              CustomUserTextFeald(lable: "Email", contrller: email),
              Gap(25),
              CustomUserTextFeald(lable: "Address", contrller: address),
              Gap(25),
              CustomUserTextFeald(lable: "Password", contrller: address),
              Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(color: AppColors.bigtextColor, thickness: 1),
              ),
              Gap(20),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(20),
                ),
                tileColor: Colors.grey.shade300,
                leading: Image.asset(
                  "assets/doler_icon/visa.png",
                  width: 50,
                  color: Colors.blueAccent,
                ),
                title: CustomText(
                  text: "Debit card ",

                  color: AppColors.medumetextcolor,
                  fontWeight: FontWeight.bold,
                  size: 15,
                ),
                subtitle: CustomText(
                  text: "**** *****12 ",
                  color: AppColors.medumetextcolor,
                ),
                trailing: CustomText(
                  text: "default",
                  color: AppColors.primaryColor,
                  size: 12,
                ),
                onTap: () {},
              ),
              Gap(100),
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
              text: "Edit Profile",
              onTap: () {
                print("Edit Profile");
              },
              icon: Icons.edit,
              width: 170,
              color: AppColors.primaryColor,
            ),
            Spacer(),
            PrimaryCustomButton(
              text: "Log Out",
              color: AppColors.primaryColor,
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginVeiw()),
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
