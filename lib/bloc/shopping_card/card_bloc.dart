import 'package:apple_shop/data/model/card_model.dart';
import 'package:apple_shop/data/repository/card_repository.dart';
import 'package:apple_shop/di/api_di.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final ICardLocalRepository _localRepository = serviceLocator.get();

  CardBloc() : super(CardInitialState()) {
    on<CardFetchedDataFromHiveEvent>((event, emit) async {
      final cardList = await _localRepository.getAllCardProducts();
      emit(CardFetchDataFromHiveState(cardList));
    });
  }
}
