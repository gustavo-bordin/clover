import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

import 'package:clover/common/constants.dart';

abstract class IPrizeRepository {
  Future<DocumentList> loadMonthlyPrize(String date);
}

class PrizeRepository implements IPrizeRepository {
  final Databases _db;

  PrizeRepository({required Databases db}) : _db = db;

  @override
  Future<DocumentList> loadMonthlyPrize(String ymDate) async {
    return await _db.listDocuments(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.prizeCollectionId,
      queries: [Query.equal("date", ymDate)],
    );
  }
}
