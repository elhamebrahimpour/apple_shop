part of 'card_bloc.dart';

abstract class CardState {}

class CardInitialState extends CardState {}

// ignore: must_be_immutable
class CardFetchDataFromHiveState extends CardState {
  Either<String, List<CardModel>> cardList;
  int? finalPrice;
  CardFetchDataFromHiveState(this.cardList, this.finalPrice);
}
