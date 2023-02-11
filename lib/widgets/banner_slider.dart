import 'package:apple_shop/bloc/home/home_bloc.dart';
import 'package:apple_shop/constants/app_colors.dart';
import 'package:apple_shop/widgets/cached_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pageController = PageController(viewportFraction: 0.8);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: ((context, state) {
        if (state is HomeLoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.blueColor,
              strokeWidth: 4,
            ),
          );
        }
        if (state is HomeResponseState) {
          return state.response.fold((l) {
            return const Center(
              child: Text('!Couldn\'t load banners'),
            );
          }, (response) {
            return Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: response.length,
                    itemBuilder: ((context, index) {
                      return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedWidget(
                                imageUrl: response[index].thumbnail),
                          ));
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
                      dotHeight: 10,
                      dotWidth: 10,
                      expansionFactor: 3,
                    ),
                  ),
                )
              ],
            );
          });
        }
        return const Center(
          child: Text('!Banners couldn\'t load'),
        );
      }),
    );
  }
}
/*
 if (state is HomeResponseState) {
          return state.response.fold((l) {
            return const Center(
              child: Text('!Couldn\'t load banners'),
            );
          }, (response) {
            return Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: response.length,
                    itemBuilder: ((context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            response[index].thumbnail!,
                            fit: BoxFit.fill,
                          ),
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
                      dotHeight: 10,
                      dotWidth: 10,
                      expansionFactor: 3,
                    ),
                  ),
                )
              ],
            );
          });
        }*/