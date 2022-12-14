import 'dart:ui';
import 'package:apple_shop/constants/app_colors.dart';
import 'package:apple_shop/data/datasource/authentication_service.dart';
import 'package:apple_shop/di/api_di.dart';
import 'package:apple_shop/screens/category_screen.dart';
import 'package:apple_shop/screens/home_screen.dart';
import 'package:apple_shop/screens/profile_screen.dart';
import 'package:apple_shop/screens/shopping_cart_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  await getItInit();
  runApp(const MyApplication());
}

class MyApplication extends StatefulWidget {
  const MyApplication({Key? key}) : super(key: key);

  @override
  State<MyApplication> createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplication> {
  int _selectedBottomNavigationItem = 3;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: IndexedStack(
          index: _selectedBottomNavigationItem,
          children: getLayouts(),
        ),
        bottomNavigationBar: fixedBottomNavigation(),
      ),
    );
  }

  List<Widget> getLayouts() {
    return <Widget>[
      const ProfileScreen(),
      const ShoppingCartScreen(),
      const CategoryScreen(),
      const HomeScreen(),
    ];
  }

  Widget fixedBottomNavigation() {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedBottomNavigationItem,
          onTap: (int index) {
            setState(() {
              _selectedBottomNavigationItem = index;
            });
          },
          selectedItemColor: AppColors.blueColor,
          selectedLabelStyle: const TextStyle(
            fontFamily: 'sb',
            fontSize: 10,
          ),
          unselectedItemColor: AppColors.blackColor,
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'sb',
            fontSize: 10,
          ),
          items: [
            BottomNavigationBarItem(
              label: '???????? ????????????',
              icon: Image.asset('images/icon_profile.png'),
              activeIcon: getActiveIconStyle('icon_profile_active'),
            ),
            BottomNavigationBarItem(
              label: '?????? ????????',
              icon: Image.asset('images/icon_basket.png'),
              activeIcon: getActiveIconStyle('icon_basket_active'),
            ),
            BottomNavigationBarItem(
              label: '???????? ????????',
              icon: Image.asset('images/icon_category.png'),
              activeIcon: getActiveIconStyle('icon_category_active'),
            ),
            BottomNavigationBarItem(
              label: '????????',
              icon: Image.asset('images/icon_home.png'),
              activeIcon: getActiveIconStyle('icon_home_active'),
            ),
          ],
        ),
      ),
    );
  }

  Widget getActiveIconStyle(String activeIcon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Ink(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.blueColor,
              blurRadius: 20,
              spreadRadius: -5,
              offset: Offset(0.0, 12),
            )
          ],
        ),
        child: Image.asset('images/$activeIcon.png'),
      ),
    );
  }
}
