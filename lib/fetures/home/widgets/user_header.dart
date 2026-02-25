import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/fetures/auth/views/shared/custom_text.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/logo/Hungry_.svg",
                              color: AppColors.primaryColor,
                              height: 35,
                            ),
                            Gap(5),
                            CustomText(
                              text:
                                  "hello, moody", //! hear will but the user name
                              color: AppColors.smalltextcolor,
                              size: 18,
                            ),
                            // Spacer(),
                          ],
                        ),
                        const Spacer(),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColors.primaryColor,
                          child: const Icon(
                            Icons.person,
                            color: AppColors.bigtextColor,
                          ),
                        ),
                      ],
                    );
  }
}