import 'package:apple_shop/constants/app_colors.dart';
import 'package:apple_shop/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: CustomAppBar(
                      title: 'سبد خرید',
                      searchIconVisibility: false,
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(bottom: 60),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return getCartItem();
                        },
                        childCount: 6,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.greenColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'ادامه فرآیند خرید',
                      style: TextStyle(
                        fontFamily: 'sb',
                        fontSize: 19,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getCartItem() {
    return Container(
      margin: const EdgeInsets.only(left: 22, right: 22, bottom: 22),
      height: 260,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
