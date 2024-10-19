import 'package:apple_shop/business/bloc/category/category_bloc.dart';
import 'package:apple_shop/business/bloc/product_category/product_category_bloc.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/presentation/screens/products_screen.dart';
import 'package:apple_shop/presentation/widgets/cached_widget.dart';
import 'package:apple_shop/presentation/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/app_colors.dart';
import '../../di/api_di.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoryBloc>(context).add(CategoryRequestLoaded());
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
                  title: 'دسته بندی',
                  searchIconVisibility: false,
                ),
              ),
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: ((context, state) {
                  if (state is CategoryLoadingState) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.blueColor,
                          strokeWidth: 4,
                        ),
                      ),
                    );
                  }
                  if (state is CategoryResponseState) {
                    return state.response.fold(
                      (error) => SliverToBoxAdapter(
                        child: Center(
                          child: Text(error),
                        ),
                      ),
                      (list) => _CategoryList(categoryList: list),
                    );
                  }
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text('!Connection Lost'),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  const _CategoryList({Key? key, required this.categoryList}) : super(key: key);
  final List<Category> categoryList;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(left: 22, right: 22, bottom: 22),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          ((context, index) {
            return GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => BlocProvider(
                        create: (context) =>
                            ProductCategoryBloc(serviceLocator.get()),
                        child: ProductsListScreen(categoryList[index]),
                      )),
                ),
              ),
              child: ImageCachedWidget(
                imageUrl: categoryList[index].thumbnail,
              ),
            );
          }),
          childCount: categoryList.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 1,
        ),
      ),
    );
  }
}
