import 'package:apple_shop/screens/login_screen.dart';
import 'package:apple_shop/utils/auth_manager.dart';
import 'package:apple_shop/utils/constants/app_colors.dart';
import 'package:apple_shop/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var list = const [];
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              const CustomAppBar(
                title: 'حساب کاربری',
                searchIconVisibility: false,
              ),
              const Text(
                'الهام ابراهیم پور',
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontFamily: 'sm',
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                '989144793143+',
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontFamily: 'sm',
                  fontSize: 10,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  ...List.generate(
                    0,
                    (index) => list[index],
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  AuthManager.logOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
                child: const Text('خروج'),
              ),
              const Spacer(),
              const Text(
                'اپل شاپ',
                style: TextStyle(
                  color: AppColors.greyColor,
                  fontFamily: 'sm',
                  fontSize: 10,
                ),
              ),
              const Text(
                'V:1.2.0',
                style: TextStyle(
                  color: AppColors.greyColor,
                  fontFamily: 'sm',
                  fontSize: 10,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  'Instagram: @elham_dev',
                  style: TextStyle(
                    color: AppColors.greyColor,
                    fontFamily: 'sm',
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
