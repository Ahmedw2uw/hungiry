import 'package:flutter/cupertino.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/fetures/auth/views/shared/custom_text.dart';

class FoodCategory extends StatefulWidget {

   FoodCategory({super.key, required this.categories, required this.selectedIndex  });
  List categories ;
  late int selectedIndex ;
  @override
  State<FoodCategory> createState() => _FoodCategoryState();
}

class _FoodCategoryState extends State<FoodCategory> {
  
  @override
  Widget build(BuildContext context) {
    return   SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(widget.categories.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.selectedIndex = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: widget.selectedIndex == index
                                    ? AppColors.primaryColor
                                    : AppColors.smalltextcolor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 15,
                              ),
                              child: CustomText(
                                text: widget.categories[index],
                                color: widget.selectedIndex == index
                                    ? AppColors.bigtextColor
                                    : AppColors.medumetextcolor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }),
                      ),
                    );
  }
}