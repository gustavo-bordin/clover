part of 'user.bloc.dart';

final class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserFailure extends UserState {
  final String failure;

  UserFailure(this.failure);
}

final class CreateUserSuccess extends UserState {
  final UserModel user;

  CreateUserSuccess(this.user);
}

final class FindUserByIdSuccess extends UserState {
  final UserModel user;

  FindUserByIdSuccess(this.user);
}

final class FindUserByIdFailure extends UserState {}

final class FindTrendingLoading extends UserState {}

final class FindTrendingSuccess extends UserState {
  List<UserModel> users;

  FindTrendingSuccess(this.users);
}

final class UpdateSuccess extends UserState {
  UserModel user;

  UpdateSuccess(this.user);
}
