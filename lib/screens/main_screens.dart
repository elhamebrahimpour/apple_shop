import 'dart:ui';
import 'package:apple_shop/bloc/category/category_bloc.dart';
import 'package:apple_shop/bloc/home/home_bloc.dart';
import 'package:apple_shop/bloc/shopping_card/card_bloc.dart';
import 'package:apple_shop/utils/constants/app_colors.dart';
import 'package:apple_shop/di/api_di.dart';
import 'package:apple_shop/screens/category_screen.dart';
import 'package:apple_shop/screens/home_screen.dart';
import 'package:apple_shop/screens/profile_screen.dart';
import 'package:apple_shop/screens/shopping_card_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedBottomNavigationItem = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedBottomNavigationItem,
        children: getLayouts(),
      ),
      bottomNavigationBar: fixedBottomNavigation(),
    );
  }

  List<Widget> getLayouts() {
    return <Widget>[
      const ProfileScreen(),
      BlocProvider(
        create: (context) => serviceLocator.get<CardBloc>()
          ..add(
            CardFetchedDataFromHiveEvent(),
          ),
        child: const ShoppingCardScreen(),
      ),
      BlocProvider(
        create: (context) => CategoryBloc(
          serviceLocator.get(),
        ),
        child: const CategoryScreen(),
      ),
      BlocProvider(
        create: (context) => HomeBloc(
          serviceLocator.get(),
          serviceLocator.get(),
          serviceLocator.get(),
        )..add(
            HomeGetRequestedEvent(),
          ),
        child: const HomeScreen(),
      ),
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
              label: 'حساب کاربری',
              icon: Image.asset('images/icon_profile.png'),
              activeIcon: getActiveIconStyle('icon_profile_active'),
            ),
            BottomNavigationBarItem(
              label: 'سبد خرید',
              icon: Image.asset('images/icon_basket.png'),
              activeIcon: getActiveIconStyle('icon_basket_active'),
            ),
            BottomNavigationBarItem(
              label: 'دسته بندی',
              icon: Image.asset('images/icon_category.png'),
              activeIcon: getActiveIconStyle('icon_category_active'),
            ),
            BottomNavigationBarItem(
              label: 'خانه',
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
