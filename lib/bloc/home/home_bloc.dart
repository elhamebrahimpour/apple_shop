import 'package:apple_shop/data/model/banner.dart';
import 'package:apple_shop/data/repository/banner_repository.dart';
import 'package:apple_shop/di/api_di.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository _repository = serviceLocator.get();
  HomeBloc() : super(HomeInitialState()) {
    on<BannerLoadedRequest>((event, emit) async {
      emit(HomeLoadingState());
      var response = await _repository.getBanners();
      emit(HomeResponseState(response));
    });
  }
}
