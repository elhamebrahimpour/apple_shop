part of 'card_bloc.dart';

@immutable
abstract class CardState {}

class CardInitialState extends CardState {}

class CardFetchDataFromHiveState extends CardState {
  Either<String, List<CardModel>> cardList;
  int? finalPrice;
  CardFetchDataFromHiveState(this.cardList, this.finalPrice);
}
