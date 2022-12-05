import 'package:apple_shop/constants/app_colors.dart';
import 'package:apple_shop/widgets/product_item.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

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
                child: CustomAppBar2(),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(left: 22, right: 22),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return const ProductItem();
                    },
                    childCount: 12,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 30,
                    childAspectRatio: 2 / 2.5,
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

class CustomAppBar2 extends StatelessWidget {
  const CustomAppBar2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 22, left: 22, bottom: 26, top: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 46,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Image.asset('images/icon_back.png'),
            const SizedBox(
              width: 10,
            ),
            const Expanded(
              child: Text(
                'پرفروش ترین ها',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.blueColor,
                  fontFamily: 'sb',
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset('images/icon_filter.png'),
          ],
        ),
      ),
    );
  }
}
