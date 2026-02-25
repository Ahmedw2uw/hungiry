import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          children: [
            Gap(280),
            SvgPicture.asset('assets/logo/Hungry_.svg'),
            Spacer(),
            Image.asset('assets/splash/hungry.png'),
          ],
        ),
      ),
    );
  }
}
