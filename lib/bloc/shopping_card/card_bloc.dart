import 'package:apple_shop/data/model/card_model.dart';
import 'package:apple_shop/data/repository/card_repository.dart';
import 'package:apple_shop/utils/payment_handler.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final ICardLocalRepository _localRepository;
  final PaymentHandler _zarinPalPaymentHandler;

  CardBloc(this._localRepository, this._zarinPalPaymentHandler)
      : super(CardInitialState()) {
    on<CardFetchedDataFromHiveEvent>((event, emit) async {
      final cardList = await _localRepository.getAllCardProducts();
      final finalPrice = await _localRepository.getShoppingCardFinalPrice();

      emit(CardFetchDataFromHiveState(cardList, finalPrice));
    });

    on<CardPaymentInitialEvent>((event, emit) async {
      _zarinPalPaymentHandler.initPaymentRequest();
    });

    on<CardPaymentRequestEvent>((event, emit) async {
      _zarinPalPaymentHandler.sendPaymentRequest();
    });
  }
}
