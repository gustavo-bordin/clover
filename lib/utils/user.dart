import 'package:clover/common/typedefs.dart';
import 'package:clover/models/user.dart';

ErrorString validateUserName(UserModel user) {
  if (user.name.isEmpty) {
    return "Nome invalido; esta vazio";
  }

  return null;
}
