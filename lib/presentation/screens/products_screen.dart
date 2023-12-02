import 'package:apple_shop/business/bloc/product_category/product_category_bloc.dart';
import 'package:apple_shop/features/utils/constants/app_colors.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/presentation/widgets/loading_animation.dart';
import 'package:apple_shop/presentation/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsListScreen extends StatefulWidget {
  final Category category;
  const ProductsListScreen(this.category, {Key? key}) : super(key: key);

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  @override
  void initState() {
    BlocProvider.of<ProductCategoryBloc>(context)
        .add(ProductCategoryRequestedEvent(widget.category.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: BlocBuilder<ProductCategoryBloc, ProductCategoryState>(
        builder: (context, state) {
          if (state is ProductCategoryLoading) {
            return const LoadingAnimation();
          }
          return SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: CustomAppBar2(widget.category.title!),
                  ),
                  if (state is ProductCategoryResponse) ...[
                    state.productsByCategoryId.fold(
                      (exception) => SliverToBoxAdapter(
                        child: Center(
                          child: Text(exception),
                        ),
                      ),
                      (productsByCategoryId) => SliverPadding(
                        padding: const EdgeInsets.only(
                            left: 22, right: 22, bottom: 44),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return ProductItem(productsByCategoryId[index]);
                            },
                            childCount: productsByCategoryId.length,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 30,
                            childAspectRatio: 2 / 2.5,
                          ),
                        ),
                      ),
                    )
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomAppBar2 extends StatelessWidget {
  final String categoryTitle;
  const CustomAppBar2(this.categoryTitle, {Key? key}) : super(key: key);

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
            Expanded(
              child: Text(
                categoryTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
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
