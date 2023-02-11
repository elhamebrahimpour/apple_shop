import 'package:apple_shop/bloc/home/home_bloc.dart';
import 'package:apple_shop/constants/app_colors.dart';
import 'package:apple_shop/data/repository/banner_repository.dart';
import 'package:apple_shop/screens/products_screen.dart';
import 'package:apple_shop/widgets/banner_slider.dart';
import 'package:apple_shop/widgets/category_items.dart';
import 'package:apple_shop/widgets/custom_appbar.dart';
import 'package:apple_shop/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(BannerLoadedRequest());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: CustomAppBar(
                    title: 'جستجوی محصولات', searchIconVisibility: true),
              ),
              const SliverToBoxAdapter(
                child: BannerSlider(),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 22, right: 22, bottom: 20, top: 22),
                  child: Text(
                    'دسته بندی',
                    style: TextStyle(
                        fontFamily: 'sb',
                        color: AppColors.greyColor,
                        fontSize: 12),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 88,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.only(right: 22),
                      child: CategoryItems(),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 22, right: 22, bottom: 20, top: 32),
                  child: Row(
                    children: [
                      const Text(
                        'پرفروش ترین ها',
                        style: TextStyle(
                            fontFamily: 'sb',
                            color: AppColors.greyColor,
                            fontSize: 12),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: ((context) {
                              return const ProductsScreen();
                            }),
                          ),
                        ),
                        child: const Text(
                          'مشاهده همه',
                          style: TextStyle(
                              fontFamily: 'sb',
                              color: AppColors.blueColor,
                              fontSize: 14),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Image.asset('images/icon_left_categroy.png'),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 242,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: ((context, index) {
                      return const Padding(
                        padding:
                            EdgeInsets.only(left: 6, bottom: 40, right: 22),
                        child: ProductItem(),
                      );
                    }),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 22, right: 22, bottom: 20),
                  child: Row(
                    children: [
                      const Text(
                        'پربازدید ترین ها',
                        style: TextStyle(
                            fontFamily: 'sb',
                            color: AppColors.greyColor,
                            fontSize: 12),
                      ),
                      const Spacer(),
                      const Text(
                        'مشاهده همه',
                        style: TextStyle(
                            fontFamily: 'sb',
                            color: AppColors.blueColor,
                            fontSize: 14),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Image.asset('images/icon_left_categroy.png'),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 242,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: ((context, index) {
                      return const Padding(
                        padding:
                            EdgeInsets.only(left: 6, bottom: 40, right: 22),
                        child: ProductItem(),
                      );
                    }),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
