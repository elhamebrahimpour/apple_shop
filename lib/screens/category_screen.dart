import 'package:apple_shop/constants/app_colors.dart';
import 'package:apple_shop/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

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
                  title: 'دسته بندی',
                  searchIconVisibility: false,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(left: 22, right: 22, bottom: 22),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    ((context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.greenColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      );
                    }),
                    childCount: 12,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 1,
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
