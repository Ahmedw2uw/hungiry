import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/fetures/auth/views/shared/custom_text.dart';
import 'package:hungry/fetures/home/widgets/card_item.dart';
import 'package:hungry/fetures/home/widgets/food_category.dart';
import 'package:hungry/fetures/home/widgets/search_feild.dart';
import 'package:hungry/fetures/home/widgets/user_header.dart';
import 'package:hungry/fetures/product/veiws/product_details_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List categories = ["All", "Combos", "Sliders", "classic", "Drinks"];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              pinned: true,
              floating: false,
              toolbarHeight: 169,
              scrolledUnderElevation: 0,
              backgroundColor: AppColors.bigtextColor,
              automaticallyImplyLeading: false,
              flexibleSpace: Padding(
                padding: EdgeInsetsGeometry.only(top: 60, right: 20, left: 20),
                child: Column(children: [UserHeader(), Gap(10), SearchFeild()]),
              ),
            ),
            //!app bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    //! categories
                    Gap(25),
                    FoodCategory(
                      categories: categories,
                      selectedIndex: selectedIndex,
                    ),

                    //! products list
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(childCount: 6, (
                  context,
                  index,
                ) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductDetailsView(),
                        ),
                      );
                    },
                    child: const CardItem(
                      image: "assets/products/h.png",
                      title: "Cheese Burger",
                      subTitle: "With extra cheese",
                      rate: "\$5.99",
                    ),
                  );
                }),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
