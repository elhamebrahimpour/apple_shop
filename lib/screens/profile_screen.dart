import 'package:apple_shop/constants/app_colors.dart';
import 'package:apple_shop/data/datasource/authentication_service.dart';
import 'package:apple_shop/widgets/category_items.dart';
import 'package:apple_shop/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var list = const [
      CategoryItems(),
      CategoryItems(),
      CategoryItems(),
      CategoryItems(),
      CategoryItems(),
      CategoryItems(),
      CategoryItems(),
      CategoryItems(),
      CategoryItems(),
      CategoryItems(),
      CategoryItems(),
      CategoryItems(),
    ];
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
                    12,
                    (index) => list[index],
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                onPressed: () {
                  AuthenticationRemote()
                      .register('elhaaam0001', '123456789', '123456789');
                },
                child: const Text('register user'),
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
