import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/fetures/auth/views/shared/custom_text.dart';
import 'package:hungry/fetures/auth/views/shared/primary_custom_button.dart';
import 'package:hungry/fetures/checkout/widget/order_widget_details.dart';
import 'package:hungry/fetures/checkout/widget/success_dialog.dart';

class ChickoutView extends StatefulWidget {
  const ChickoutView({super.key});

  @override
  State<ChickoutView> createState() => _ChickoutViewState();
}

class _ChickoutViewState extends State<ChickoutView> {
  String? selectedMethod = "chash";
  bool? onchange = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bigtextColor,
        elevation: 0,
        scrolledUnderElevation: 0.0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Order summary",
                size: 21,
                fontWeight: FontWeight.w500,
              ),
              Gap(10),
              OrderWidgetDetails(
                order: "200",
                fees: "\$1.5",
                taxes: "\$0.30",
                total: "\$201.8",
              ),

              Gap(50),
              //chash
              CustomText(
                text: "payment Methods ",
                size: 21,
                fontWeight: FontWeight.w500,
              ),
              Gap(20),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(8),
                ),
                tileColor: Color(0xff3C2F2F),
                leading: Image.asset("assets/doler_icon/doler.png", width: 50),
                title: CustomText(
                  text: "Cash on Delivery",
                  color: AppColors.bigtextColor,
                  fontWeight: FontWeight.bold,
                  size: 20,
                ),
                trailing: Radio<String>(
                  activeColor: AppColors.bigtextColor,
                  value: "chash",
                  groupValue: selectedMethod,
                  onChanged: (v) {
                    setState(() {
                      selectedMethod = v!;
                    });
                  },
                ),
                onTap: () {
                  setState(() {
                    selectedMethod = "chash";
                  });
                },
              ),
              Gap(20),
              //visa
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(8),
                ),
                tileColor: Colors.blue.shade900,
                leading: Image.asset(
                  "assets/doler_icon/visa.png",
                  width: 50,
                  color: AppColors.bigtextColor,
                ),
                title: CustomText(
                  text: "Debit card ",

                  color: Color(0xffF3F4F6),
                  fontWeight: FontWeight.bold,
                  size: 20,
                ),
                subtitle: CustomText(
                  text: "**** *****12 ",
                  color: Color(0xffF3F4F6),
                ),
                trailing: Radio<String>(
                  activeColor: AppColors.bigtextColor,
                  value: "visa",
                  groupValue: selectedMethod,
                  onChanged: (v) {
                    setState(() {
                      selectedMethod = v!;
                    });
                  },
                ),
                onTap: () {
                  setState(() {
                    selectedMethod = "visa";
                  });
                },
              ),
              Gap(5),
              Row(
                children: [
                  Checkbox(
                    value: onchange,
                    onChanged: (v) {
                      setState(() {
                        onchange = v;
                      });
                    },
                    activeColor: Color(0xffEF2A39),
                  ),
                  CustomText(
                    text: "Save card details for future payments",
                    color: AppColors.smalltextcolor,
                    size: 15,
                  ),
                ],
              ),
              Gap(80),
            ],
          ),
        ),
      ),

      bottomSheet: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.smalltextcolor,
              blurRadius: 15,
              offset: Offset(0, 0),
            ),
          ],
        ),
        height: 120,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Total Price ",
                    size: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  Gap(5),
                  CustomText(text: "\$ 12.99", size: 25),
                ],
              ),
              Spacer(),
              PrimaryCustomButton(
                text: "Pay Now",
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: AppColors.bigtextColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: AppColors.primaryColor,
                                child: Icon(
                                  CupertinoIcons.check_mark,
                                  color: AppColors.bigtextColor,
                                ),
                              ),
                              const Gap(15),
                              CustomText(
                                text: "Success",
                                size: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              const Gap(10),
                              Center(
                                child: CustomText(
                                  text:
                                      "Your payment was successful.\nA receipt has been sent to your email.",
                                ),
                              ),
                              const Gap(20),
                              PrimaryCustomButton(
                                text: "Go Back",
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
