import 'package:apple_shop/business/bloc/home/home_bloc.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/presentation/widgets/banner_slider.dart';
import 'package:apple_shop/presentation/widgets/category_item_chip.dart';
import 'package:apple_shop/presentation/widgets/custom_appbar.dart';
import 'package:apple_shop/presentation/widgets/loading_animation.dart';
import 'package:apple_shop/presentation/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return const LoadingAnimation();
        }
        return Scaffold(
          backgroundColor: AppColors.backColor,
          body: SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<HomeBloc>().add(HomeGetRequestedEvent());
                },
                child: CustomScrollView(
                  slivers: [
                    //get search appbar
                    const SliverToBoxAdapter(
                      child: CustomAppBar(
                        title: 'جستجوی محصولات',
                        searchIconVisibility: true,
                      ),
                    ),

                    if (state is HomeResponseState) ...{
                      //get banners
                      state.banners.fold((exception) {
                        return SliverToBoxAdapter(
                          child: Center(
                            child: exception.isNotEmpty
                                ? const Text('!Couldn\'t load banners')
                                : const LoadingAnimation(),
                          ),
                        );
                      }, (bannerList) {
                        return SliverToBoxAdapter(
                          child: BannerSlider(bannerList),
                        );
                      }),

                      //get categories
                      const _GetCategoriesListTitle(),
                      state.categories.fold(
                        (exception) => SliverToBoxAdapter(
                          child: Center(
                            child: Text(exception),
                          ),
                        ),
                        (categoryList) => _GetCategoriesList(categoryList),
                      ),

                      //get best selling products
                      const _GetBestSellingProductsTitle(),
                      state.bestSellerproducts.fold(
                        (exception) => SliverToBoxAdapter(
                          child: Center(
                            child: Text(exception),
                          ),
                        ),
                        (productList) => _GetBestSellingProducts(productList),
                      ),

                      //get most visited products
                      const _GetMostVisitedProductsTitle(),
                      state.hotestproducts.fold(
                        (exception) => SliverToBoxAdapter(
                          child: Center(
                            child: Text(exception),
                          ),
                        ),
                        (productList) => _GetMostVisitedProducts(productList),
                      ),
                    }
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _GetMostVisitedProducts extends StatelessWidget {
  const _GetMostVisitedProducts(this.productList, {Key? key}) : super(key: key);
  final List<Product> productList;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 242,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productList.length,
          itemBuilder: ((context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 6, bottom: 40, right: 22),
              child: ProductItem(productList[index]),
            );
          }),
        ),
      ),
    );
  }
}

class _GetMostVisitedProductsTitle extends StatelessWidget {
  const _GetMostVisitedProductsTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 22, right: 22, bottom: 20),
        child: Row(
          children: [
            const Text(
              'پربازدید ترین ها',
              style: TextStyle(
                  fontFamily: 'sb', color: AppColors.greyColor, fontSize: 12),
            ),
            const Spacer(),
            const Text(
              'مشاهده همه',
              style: TextStyle(
                  fontFamily: 'sb', color: AppColors.blueColor, fontSize: 14),
            ),
            const SizedBox(
              width: 5,
            ),
            Image.asset('images/icon_left_categroy.png'),
          ],
        ),
      ),
    );
  }
}

class _GetBestSellingProducts extends StatelessWidget {
  const _GetBestSellingProducts(this.productList, {Key? key}) : super(key: key);
  final List<Product> productList;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 242,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productList.length,
          itemBuilder: ((context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 6, bottom: 40, right: 22),
              child: ProductItem(productList[index]),
            );
          }),
        ),
      ),
    );
  }
}

class _GetBestSellingProductsTitle extends StatelessWidget {
  const _GetBestSellingProductsTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 22, right: 22, bottom: 20, top: 32),
        child: Row(
          children: [
            const Text(
              'پرفروش ترین ها',
              style: TextStyle(
                  fontFamily: 'sb', color: AppColors.greyColor, fontSize: 12),
            ),
            const Spacer(),
            const Text(
              'مشاهده همه',
              style: TextStyle(
                  fontFamily: 'sb', color: AppColors.blueColor, fontSize: 14),
            ),
            const SizedBox(
              width: 5,
            ),
            Image.asset('images/icon_left_categroy.png'),
          ],
        ),
      ),
    );
  }
}

class _GetCategoriesList extends StatelessWidget {
  const _GetCategoriesList(this.categoryList, {Key? key}) : super(key: key);
  final List<Category> categoryList;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 88,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoryList.length,
          itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(right: 22),
              child: CategoryItemChip(categoryList[index])),
        ),
      ),
    );
  }
}

class _GetCategoriesListTitle extends StatelessWidget {
  const _GetCategoriesListTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(left: 22, right: 22, bottom: 20, top: 22),
        child: Text(
          'دسته بندی',
          style: TextStyle(
              fontFamily: 'sb', color: AppColors.greyColor, fontSize: 12),
        ),
      ),
    );
  }
}
