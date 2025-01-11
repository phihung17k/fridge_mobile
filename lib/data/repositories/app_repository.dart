import 'package:fridge_mobile/data/repositories/i_app_repository.dart';

class AppRepository implements IAppRepository {
  @override
  Future<bool> delete(String table, int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<bool> initData() {
    // TODO: implement initData
    throw UnimplementedError();
  }

  @override
  Future<int> insert(String table, Map<String, Object?> values) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<bool> insertBatch(String table, List<Map<String, Object?>> valueList) {
    // TODO: implement insertBatch
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, Object?>>> queryAll(String table, {String? orderBy}) {
    // TODO: implement queryAll
    throw UnimplementedError();
  }

  @override
  Future<Map<String, Object?>> queryFromId(String table, int id) {
    // TODO: implement queryFromId
    throw UnimplementedError();
  }

  @override
  Future<bool> reorder(String table, Map<int, int> idOrdinalMap) {
    // TODO: implement reorder
    throw UnimplementedError();
  }

  @override
  Future<int> update(String table, Map<String, Object?> values) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
