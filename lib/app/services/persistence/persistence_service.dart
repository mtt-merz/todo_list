abstract class PersistenceService {
  Future<void> insertJson(String key, String id, Map<String, dynamic> json);

  Future<List<Map<String, dynamic>>> getAllJson(String key);

  Future<void> removeFromId(String key, String id);
}
