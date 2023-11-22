part of 'card_bloc.dart';

abstract class CardEvent {}

class CardFetchedDataFromHiveEvent extends CardEvent {}

class CardPaymentInitialEvent extends CardEvent {}

class CardPaymentRequestEvent extends CardEvent {}

class CardRemoveProductEvent extends CardEvent {
  final int index;
  CardRemoveProductEvent(this.index);
}

class CardDeleteBoxEvent extends CardEvent {}
