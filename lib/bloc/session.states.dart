part of 'session.bloc.dart';

final class SessionState {}

final class SessionInitial extends SessionState {}

final class SessionLoading extends SessionState {}

final class SessionFailure extends SessionState {
  final String failure;

  SessionFailure(this.failure);
}

final class GetSessionSuccess extends SessionState {
  final AppwriteSession session;

  GetSessionSuccess(this.session);
}

final class GetSessionFailure extends SessionState {}

final class CreateGoogleSessionSuccess extends SessionState {}

final class CreatePhoneSessionSuccess extends SessionState {
  final String userId;

  CreatePhoneSessionSuccess(this.userId);
}

final class ConfirmPhoneSessionSuccess extends SessionState {}
