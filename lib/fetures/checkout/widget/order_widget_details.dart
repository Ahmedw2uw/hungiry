import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/fetures/auth/views/shared/custom_text.dart';

class OrderWidgetDetails extends StatelessWidget {
   OrderWidgetDetails({super.key,required this.order,required this.fees,required this.taxes,required this.total,});
  String order,taxes,fees,total;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
            checkoutWidget("Order", order, false),
            Gap(10),
            checkoutWidget("Taxes", taxes, false),

            Gap(10),
            checkoutWidget("Delivery fees", fees, false),
            Gap(5),
            Divider(color: AppColors.smalltextcolor),
            Gap(5),
            checkoutWidget("Total", total, true),
            Gap(5),
            checkoutWidget("Estimated delivery time :", "15 - 30 mins", false),
      ],
    );
  }
}

Widget checkoutWidget(title, price, isBold) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: title,
          color: isBold ? AppColors.medumetextcolor : AppColors.smalltextcolor,
          size: isBold ? 19 : 17,
          fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
        ),
        Spacer(),
        CustomText(
          text: "$price \$",
          color: isBold ? AppColors.medumetextcolor : AppColors.smalltextcolor,

          size: isBold ? 19 : 17,

          fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
        ),
      ],
    ),
  );
}
