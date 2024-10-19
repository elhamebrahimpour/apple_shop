import 'package:apple_shop/business/bloc/shopping_card/card_bloc.dart';
import 'package:apple_shop/presentation/screens/login_screen.dart';
import 'package:apple_shop/core/utils/auth_manager.dart';
import 'package:apple_shop/core/constants/app_colors.dart';
import 'package:apple_shop/core/utils/extensions/context_extension.dart';
import 'package:apple_shop/presentation/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              Text(
                AuthManager.readUserName(),
                style: const TextStyle(
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
                spacing: 36,
                runSpacing: 30,
                children: [
                  const ProfileItemChip(
                    title: 'تنظیمات',
                    icon: 'p_settings',
                  ),
                  const ProfileItemChip(
                    title: 'سفارشات اخیر',
                    icon: 'p_recent_orders',
                  ),
                  const ProfileItemChip(
                    title: 'آدرس ها',
                    icon: 'p_address',
                  ),
                  const ProfileItemChip(
                    title: 'بلاگ',
                    icon: 'p_blog',
                  ),
                  const ProfileItemChip(
                    title: 'نقد و نظرات',
                    icon: 'p_comments',
                  ),
                  const ProfileItemChip(
                    title: 'تخفیف ها',
                    icon: 'p_on_sale',
                  ),
                  const ProfileItemChip(
                    title: 'اطلاعیه',
                    icon: 'p_notif',
                  ),
                  const ProfileItemChip(
                    title: 'علاقه مندی‌ها',
                    icon: 'p_favorites',
                  ),
                  const ProfileItemChip(
                    title: 'پشتیبانی',
                    icon: 'p_support',
                  ),
                  const ProfileItemChip(
                    title: 'سفارش در حال انجام',
                    icon: 'p_orders',
                  ),
                  ProfileItemChip(
                    title: 'خروج',
                    icon: 'p_exit',
                    onChipTapped: () {
                      BlocProvider.of<CardBloc>(context).add(
                        CardDeleteBoxEvent(),
                      );

                      AuthManager.logOut();
                      context.navigateToScreen(
                        LoginScreen(),
                      );
                    },
                  ),
                ],
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

class ProfileItemChip extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback? onChipTapped;

  const ProfileItemChip({
    required this.title,
    required this.icon,
    this.onChipTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChipTapped!.call(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: ShapeDecoration(
              color: const Color(0xff3b5edf),
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(46),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0xff3b5edf),
                  blurRadius: 20,
                  spreadRadius: -8,
                  offset: Offset(0.0, 8),
                )
              ],
            ),
            child: Center(
              child: Image.asset(
                'images/$icon.png',
                height: 26,
                width: 26,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.blackColor,
              fontSize: 12,
              fontFamily: 'sm',
            ),
          ),
        ],
      ),
    );
  }
}
