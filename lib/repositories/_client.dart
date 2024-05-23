import 'package:appwrite/appwrite.dart';

import 'package:clover/common/constants.dart';

class AppwriteClient {
  late Account account;
  late Databases db;

  AppwriteClient() {
    final client = Client()
        .setEndpoint(AppwriteConstants.endpoint)
        .setProject(AppwriteConstants.projectId)
        .setSelfSigned(status: true);

    account = Account(client);
    db = Databases(client);
  }
}
