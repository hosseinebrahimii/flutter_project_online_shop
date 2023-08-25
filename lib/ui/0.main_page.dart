import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_project_online_shop/constants/colors.dart';
import 'package:flutter_project_online_shop/ui/1.0.home_page.dart';
import 'package:flutter_project_online_shop/ui/2.category_page.dart';
import 'package:flutter_project_online_shop/ui/3.0.purchase_cart_page.dart';
import 'package:flutter_project_online_shop/ui/4.profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

int bottomNavigationBarIndex = 3;

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: IndexedStack(
        index: bottomNavigationBarIndex,
        children: const [
          ProfilePage(),
          PurchaseCartPage(),
          CategoryPage(),
          HomePage(),
        ],
      ),
      bottomNavigationBar: _getBottomNavigationBar(),
    );
  }

  Widget _getBottomNavigationBar() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 20),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: bottomNavigationBarIndex,
            items: [
              BottomNavigationBarItem(
                icon: _getBottomNavigationBarItemIcon(imageAddress: 'assets/images/icon_profile.png'),
                activeIcon: _getBottomNavigationBarItemIcon(
                    isActive: true, imageAddress: 'assets/images/icon_profile_active.png'),
                label: 'حساب کاربری',
              ),
              BottomNavigationBarItem(
                icon: _getBottomNavigationBarItemIcon(imageAddress: 'assets/images/icon_basket.png'),
                activeIcon: _getBottomNavigationBarItemIcon(
                    isActive: true, imageAddress: 'assets/images/icon_basket_active.png'),
                label: 'سبد خرید',
              ),
              BottomNavigationBarItem(
                icon: _getBottomNavigationBarItemIcon(imageAddress: 'assets/images/icon_category.png'),
                activeIcon: _getBottomNavigationBarItemIcon(
                    isActive: true, imageAddress: 'assets/images/icon_category_active.png'),
                label: 'دسته بندی',
              ),
              BottomNavigationBarItem(
                icon: _getBottomNavigationBarItemIcon(imageAddress: 'assets/images/icon_home.png'),
                activeIcon:
                    _getBottomNavigationBarItemIcon(isActive: true, imageAddress: 'assets/images/icon_home_active.png'),
                label: 'خانه',
              ),
            ],
            selectedLabelStyle: const TextStyle(
              fontFamily: 'SB',
              color: CustomColors.blue,
              fontSize: 10,
            ),
            selectedItemColor: CustomColors.blue,
            showSelectedLabels: true,
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'SB',
              color: Colors.black,
              fontSize: 10,
            ),
            unselectedItemColor: Colors.black,
            showUnselectedLabels: true,
            onTap: (value) {
              setState(() {
                bottomNavigationBarIndex = value;
              });
            },
          ),
        ),
      ),
    );
  }

  Container _getBottomNavigationBarItemIcon({
    required String imageAddress,
    bool isActive = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: isActive ? CustomColors.blue : Colors.black,
            blurRadius: 20,
            spreadRadius: -7,
            offset: const Offset(0, 13),
          ),
        ],
      ),
      child: Image.asset(imageAddress),
    );
  }
}
