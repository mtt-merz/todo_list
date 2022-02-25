import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import 'persistence_service.dart';

class SembastWrapper extends PersistenceService {
  /// Initialize the plugin
  static Future<SembastWrapper> initialize() async {
    var dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    var dbPath = join(dir.path, 'my_database.db');

    var db = await databaseFactoryIo.openDatabase(dbPath);
    return SembastWrapper._(db);
  }

  final Database _db;

  SembastWrapper._(this._db);

  @override
  Future<void> insertJson(String key, String id, Map<String, dynamic> json) =>
      _store(key).record(id).put(_db, json);

  @override
  Future<void> removeFromId(String key, String id) => _store(key).record(id).delete(_db);

  @override
  Future<List<Map<String, dynamic>>> getAllJson(String key) => _store(key)
      .find(_db)
      .then((records) => records.map((element) => element.value as Map<String, dynamic>).toList());

  /// Get the [StoreRef] instance relative to the [key] param
  StoreRef _store(String key) => stringMapStoreFactory.store(key);
}
