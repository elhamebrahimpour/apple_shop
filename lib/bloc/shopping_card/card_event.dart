part of 'card_bloc.dart';

@immutable
abstract class CardEvent {}

class CardFetchedDataFromHiveEvent extends CardEvent {}
