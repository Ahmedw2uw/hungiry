import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry/core/constant/app_colors.dart';
import 'package:hungry/fetures/auth/views/profile_veiw.dart';
import 'package:hungry/fetures/cart/views/cart_view.dart';
import 'package:hungry/fetures/home/views/home_view.dart';
import 'package:hungry/fetures/orderHistory/views/order_history_view.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late final PageController controller;
  late List<Widget> screans;
  int currentScrean = 0;

  @override
  void initState() {
    screans = [HomeView(), CartView(), OrderHistoryView(), ProfileVeiw()];
    controller = PageController(initialPage: currentScrean);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: screans,
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.bigtextColor,
          unselectedItemColor: Colors.grey.shade500.withOpacity(0.7),
          currentIndex: currentScrean,
          onTap: (index) {
            setState(() {
              currentScrean = index;
            });
            controller.jumpToPage(currentScrean);
          },

          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.cart),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_restaurant_sharp),
              label: "Orders",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
