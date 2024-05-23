import 'package:flutter/foundation.dart';

@immutable
class PrizeModel {
  final double prizeAmount;

  const PrizeModel({required this.prizeAmount});

  factory PrizeModel.fromMap(Map<String, dynamic> map) {
    return PrizeModel(prizeAmount: map["prize_amount"]?.toDouble());
  }
}
