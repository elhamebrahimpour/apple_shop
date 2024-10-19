import 'package:apple_shop/core/utils/extensions/context_extension.dart';
import 'package:apple_shop/presentation/screens/login_screen.dart';
import 'package:apple_shop/presentation/screens/main_screens.dart';
import 'package:apple_shop/core/utils/auth_manager.dart';
import 'package:apple_shop/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.blueColor,
        image: DecorationImage(
          repeat: ImageRepeat.repeat,
          opacity: 0.6,
          image: AssetImage('images/star_pattern.png'),
        ),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            LogoWidget(),
            SloganWidget(),
            StartIcon(),
            AppFooter(),
          ],
        ),
      ),
    );
  }
}

class AppFooter extends StatelessWidget {
  const AppFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      width: double.infinity,
      child: const Column(
        children: [
          Text(
            'From',
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 12,
              fontFamily: 'sm',
            ),
          ),
          Text(
            'Shop',
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 12,
              fontFamily: 'sm',
            ),
          ),
        ],
      ),
    );
  }
}

class StartIcon extends StatelessWidget {
  const StartIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.navigateToScreen(
        const DashboardScreen(),
      ),
      //navigateToLoginScreen(context),
      child: Container(
        margin: const EdgeInsets.only(right: 22, bottom: 70),
        height: 70,
        width: 70,
        decoration: const BoxDecoration(
          color: AppColors.blue,
          shape: BoxShape.circle,
        ),
        child: Image.asset('images/icon_right_arrow_cricle.png'),
      ),
    );
  }
}

class SloganWidget extends StatelessWidget {
  const SloganWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'اوج هیجان با خرید',
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 30,
              fontFamily: 'sb',
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            '!محصولات اپل',
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 30,
              fontFamily: 'sb',
            ),
          ),
        ],
      ),
    );
  }
}

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('images/splash_back.png'),
            Positioned(
              top: 180,
              child: SizedBox(
                height: 90,
                width: 90,
                child: Image.asset('images/icon_app.png'),
              ),
            ),
            const Positioned(
              bottom: 170,
              child: Text(
                'اپل شاپ',
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 18,
                  fontFamily: 'sb',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future navigateToLoginScreen(BuildContext context) {
  return Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) {
        return AuthManager.isUserLoggedin()
            ? const DashboardScreen()
            : LoginScreen();
      },
    ),
  );
}
