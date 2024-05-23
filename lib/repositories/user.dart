import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

import 'package:clover/common/constants.dart';
import 'package:clover/common/typedefs.dart';
import 'package:clover/models/user.dart';

abstract class IUserRepository {
  Future<Nothing> create(UserModel userModel);
  Future<Document?> findById(String uid);
}

class UserRepository implements IUserRepository {
  final Databases _db;

  UserRepository({required Databases db}) : _db = db;

  @override
  Future<Document> create(UserModel userModel) async {
    return await _db.createDocument(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.usersCollectionId,
      documentId: userModel.id,
      data: userModel.toMap(),
    );
  }

  @override
  Future<Document> findById(String uid) async {
    return await _db.getDocument(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.usersCollectionId,
      documentId: uid,
    );
  }

  Future<DocumentList> findTrending(int limit) async {
    return _db.listDocuments(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.usersCollectionId,
      queries: [
        Query.orderDesc("trevos"),
        Query.limit(limit),
      ],
    );
  }

  Future<Document> update(String userId, Map<String, dynamic> data) async {
    return await _db.updateDocument(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.usersCollectionId,
      documentId: userId,
      data: data,
    );
  }
}
