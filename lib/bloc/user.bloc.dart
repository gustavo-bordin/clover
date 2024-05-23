import 'package:appwrite/appwrite.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:clover/models/user.dart';
import 'package:clover/repositories/user.dart';
import 'package:clover/utils/_exports.dart';

part './user.states.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required userRepository})
      : _userRepository = userRepository,
        super(UserInitial());

  final UserRepository _userRepository;

  void create(UserModel user) async {
    emit(UserLoading());

    final error = validateUserName(user);
    if (error != null) return emit(UserFailure(error));

    try {
      final created = await _userRepository.create(user);
      final newUser = UserModel.fromMap(created.data);
      emit(CreateUserSuccess(newUser));
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }

  void findById(String userId) async {
    emit(UserLoading());

    try {
      final found = await _userRepository.findById(userId);
      final user = UserModel.fromMap(found.data);
      emit(FindUserByIdSuccess(user));
    } on AppwriteException catch (e) {
      if (e.type == "document_not_found") return emit(FindUserByIdFailure());
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }

  void findTrending() async {
    emit(FindTrendingLoading());
    try {
      final found = await _userRepository.findTrending(3);
      final users = UserModel.fromDocumentList(found.documents);

      emit(FindTrendingSuccess(users));
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }

  void update(UserModel user) async {
    emit(UserLoading());

    final error = validateUserName(user);
    if (error != null) return emit(UserFailure(error));

    try {
      final updated = await _userRepository.update(user.id, user.toMap());
      final newUser = UserModel.fromMap(updated.data);

      emit(UpdateSuccess(newUser));
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }
}
