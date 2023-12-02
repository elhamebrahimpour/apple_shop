import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/data/repository/category_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ICategoryRepository _categoryRepository;
  CategoryBloc(this._categoryRepository) : super(CategoryInitialState()) {
    on<CategoryEvent>((event, emit) async {
      emit(CategoryLoadingState());
      var response = await _categoryRepository.getCategoryList();
      emit(CategoryResponseState(response));
    });
  }
}
