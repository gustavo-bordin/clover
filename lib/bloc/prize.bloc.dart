import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:clover/models/prize.dart';
import 'package:clover/repositories/prize.dart';

part './prize.states.dart';

class PrizeCubit extends Cubit<PrizeState> {
  PrizeCubit({required prizeRepository})
      : _prizeRepository = prizeRepository,
        super(PrizeInitial());

  final PrizeRepository _prizeRepository;

  void loadMonthlyPrize() async {
    emit(PrizeLoading());

    try {
      DateTime now = DateTime.now();
      DateFormat formatter = DateFormat('MM-yy');

      final ymDate = formatter.format(now);
      final found = await _prizeRepository.loadMonthlyPrize(ymDate);
      final prize = PrizeModel.fromMap(found.documents.first.data);
      emit(LoadPrizeSuccess(prize));
    } catch (e) {
      emit(PrizeFailure(e.toString()));
    }
  }
}
