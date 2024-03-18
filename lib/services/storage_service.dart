

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
class StorageService {

  // putting this here for now
  static String getUrl()
  {    
   return dotenv.env['API_URL'] ?? '';
  }

  FlutterSecureStorage getSecureStorage() {    
    // Create storage
    final storage = FlutterSecureStorage();
    return storage;
  }

 // Read value
 Future<String?> readSecureData(String key) async {
  String? value = await getSecureStorage().read(key: key);
  return value;
 }

// Read all values
// Map<String, String> allValues = await storage.readAll();
  Future<void> deleteKey(String key) async {
      // Delete value
      await getSecureStorage().delete(key: key);
  }

  Future<void> deleteAll() async {
        // Delete all
        await getSecureStorage().deleteAll();
  }
  
  Future<void> write(String key, String? value) async {
        // Write Value
        await getSecureStorage().write(key: key, value: value);
  }

}