import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:salt/services/auth.dart';
import 'package:salt/services/storage_service.dart';
class AddressListService {



  Future<Map> getAll() async {
      final String bearerToken = await AuthService().getBearerAuth();
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': bearerToken
      };
      var response = await http.get(Uri.parse('${StorageService.getUrl()}/api/addressList/all'), headers: headers);

 
      // TODO better error handling
      if (response.statusCode == 200) {
        return {"success" : true, "result": response};
      } else {
        return {"success" : false};
      }
  }
  
}