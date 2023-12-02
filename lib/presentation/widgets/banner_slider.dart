import 'package:apple_shop/features/utils/constants/app_colors.dart';
import 'package:apple_shop/data/model/banner.dart';
import 'package:apple_shop/presentation/widgets/cached_widget.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider(this.bannerList, {Key? key}) : super(key: key);
  final List<AdvertiseBanner> bannerList;

  @override
  Widget build(BuildContext context) {
    var pageController = PageController(viewportFraction: 0.9);
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        SizedBox(
          height: 177,
          width: double.infinity,
          child: PageView.builder(
            controller: pageController,
            itemCount: bannerList.length,
            itemBuilder: ((context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                child: ImageCachedWidget(
                  imageUrl: bannerList[index].thumbnail,
                  radius: 15,
                ),
              );
            }),
          ),
        ),
        Positioned(
          bottom: 12,
          child: SmoothPageIndicator(
            controller: pageController,
            count: 3,
            effect: const ExpandingDotsEffect(
              dotColor: AppColors.whiteColor,
              activeDotColor: AppColors.blueIndicator,
              dotHeight: 7,
              dotWidth: 7,
              expansionFactor: 3,
            ),
          ),
        )
      ],
    );
  }
}
