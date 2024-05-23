import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

import 'package:clover/common/typedefs.dart';

abstract class ISessionRepository {
  Future<String> createPhoneSession(String phoneNumber);
  Future<Nothing> confirmPhoneSession(String userId, String otp);
  Future<Nothing> createGoogleSession();
  Future<AppwriteSession?> get();
  Future<Nothing> logout();
}

class SessionRepository implements ISessionRepository {
  final Account _account;

  SessionRepository({required Account account}) : _account = account;

  @override
  Future<String> createPhoneSession(String phoneNumber) async {
    Token token = await _account.createPhoneSession(userId: ID.unique(), phone: phoneNumber);
    return token.userId;
  }

  @override
  Future<Nothing> confirmPhoneSession(String userId, String otp) async {
    await _account.updatePhoneSession(userId: userId, secret: otp);
  }

  @override
  Future<Nothing> createGoogleSession() async {
    await _account.createOAuth2Session(provider: "google");
  }

  @override
  Future<AppwriteSession> get() async {
    return await _account.get();
  }

  @override
  Future<Nothing> logout() async {
    await _account.deleteSession(sessionId: 'current');
  }
}
