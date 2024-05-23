import 'package:appwrite/appwrite.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/countries.dart';

import 'package:clover/common/typedefs.dart';
import 'package:clover/repositories/session.dart';
import 'package:clover/utils/_exports.dart';

part './session.states.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit({required sessionRepository})
      : _sessionRepository = sessionRepository,
        super(SessionInitial());

  final SessionRepository _sessionRepository;

  void createPhoneSession(String phoneNumber, Country country) async {
    emit(SessionLoading());

    final error = validatePhoneNumber(phoneNumber, country);
    if (error != null) return emit(SessionFailure("Numero de telefone invalido"));

    final completeNumber = getCompleteNumber(phoneNumber, country);

    try {
      final userId = await _sessionRepository.createPhoneSession(completeNumber);
      emit(CreatePhoneSessionSuccess(userId));
    } catch (e) {
      emit(SessionFailure(e.toString()));
    }
  }

  void confirmPhoneSession(String userId, String otpCode) async {
    emit(SessionLoading());

    final error = validateOtpCode(otpCode);
    if (error != null) return emit(SessionFailure(error));

    try {
      await _sessionRepository.confirmPhoneSession(userId, otpCode);
      emit(ConfirmPhoneSessionSuccess());
    } catch (e) {
      emit(SessionFailure(e.toString()));
    }
  }

  void createGoogleSession() async {
    emit(SessionLoading());

    try {
      await _sessionRepository.createGoogleSession();
      emit(CreateGoogleSessionSuccess());
    } catch (e) {
      emit(SessionFailure(e.toString()));
    }
  }

  void get() async {
    emit(SessionLoading());
    try {
      final session = await _sessionRepository.get();
      emit(GetSessionSuccess(session));
    } on AppwriteException catch (e) {
      if (e.type == "general_unauthorized_scope") emit(GetSessionFailure());
    } catch (e) {
      emit(SessionFailure(e.toString()));
    }
  }
}
