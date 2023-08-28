import 'package:apple_shop/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 80, bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
              child: SizedBox(
                width: 340,
                height: 340,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Image.asset('images/splash_back.png'),
                    Positioned(
                      bottom: 148,
                      child: SizedBox(
                        height: 84,
                        width: 100,
                        child: Image.asset('images/icon_app.png'),
                      ),
                    ),
                    const Positioned(
                      bottom: 110,
                      child: Text(
                        'اپل شاپ',
                        style: TextStyle(
                          fontFamily: 'sb',
                          fontSize: 20,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 16, left: 210),
              child: Text(
                'اوج هیجان با',
                style: TextStyle(
                  fontFamily: 'sb',
                  fontSize: 28,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 16, left: 130),
              child: Text(
                '!خرید محصولات اپل',
                style: TextStyle(
                  fontFamily: 'sb',
                  fontSize: 28,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            Container(
              height: 38,
              margin: const EdgeInsets.only(
                right: 22,
                top: 32,
                bottom: 32,
                left: 300,
              ),
              decoration: BoxDecoration(
                color: const Color(0xff253DEE),
                shape: BoxShape.circle,
                border: Border.all(
                  strokeAlign: BorderSide.strokeAlignOutside,
                  color: const Color(0xff253DEE),
                  width: 10,
                ),
              ),
              child: Image.asset('images/icon_arrow_right.png'),
            ),
            const Spacer(),
            const Text(
              'From',
              style: TextStyle(
                fontFamily: 'gb',
                fontSize: 12,
                color: Color(0xff86A5F8),
              ),
            ),
            const Text(
              'Shopping center',
              style: TextStyle(
                fontFamily: 'gb',
                fontSize: 12,
                color: AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
