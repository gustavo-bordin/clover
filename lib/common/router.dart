import 'package:flutter/material.dart';

import 'package:clover/common/typedefs.dart';
import 'package:clover/main.dart';
import 'package:clover/models/user.dart';
import 'package:clover/views/account/account.dart';
import 'package:clover/views/bundles/bundles.dart';
import 'package:clover/views/home/home.dart';
import 'package:clover/views/session/login.dart';
import 'package:clover/views/session/otp_code.dart';
import 'package:clover/views/session/user_data.dart';
import 'package:clover/views/splash/loading.dart';

class Routing {
  final BuildContext context;

  Routing(this.context);

  askOtpCode({required String userId, required String phoneNumber}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AskOtpCode(
          userId: userId,
          phoneNumber: phoneNumber,
        ),
      ),
    );
  }

  askPhoneNumber() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const AskPhoneNumber(),
      ),
      (route) => false,
    );
  }

  askUserData({required AppwriteSession session}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AskUserData(session: session),
      ),
    );
  }

  entryLoading() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoadingSplash(),
      ),
    );
  }

  entrypoint() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const AppView(),
      ),
      (route) => false,
    );
  }

  home(UserModel user) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => Home(user: user),
      ),
      (route) => false,
    );
  }

  bundles(UserModel user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Bundles(user: user),
      ),
    );
  }

  account(UserModel user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Account(user: user),
      ),
    );
  }
}
