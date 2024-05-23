part of './prize.bloc.dart';

final class PrizeState {}

final class PrizeInitial extends PrizeState {}

final class PrizeLoading extends PrizeState {}

final class PrizeFailure extends PrizeState {
  final String failure;

  PrizeFailure(this.failure);
}

final class LoadPrizeSuccess extends PrizeState {
  final PrizeModel prize;

  LoadPrizeSuccess(this.prize);
}
