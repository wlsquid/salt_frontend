import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:salt/services/auth.dart';
import 'package:salt/services/storage_service.dart';

class AddressDataService {

  Future<Map> getAllByListId(int listId) async {
      final String bearerToken = await AuthService().getBearerAuth();
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': bearerToken
      };
      var response = await http.get(Uri.parse('${StorageService.getUrl()}/api/addressData/$listId'), headers: headers);

 
      // TODO better error handling
      if (response.statusCode == 200) {
        return {"success" : true, "result": response};
      } else {
        return {"success" : false};
      }
  }

  
  Future<Map> updateData(int dataId, Map body) async {
      final String bearerToken = await AuthService().getBearerAuth();
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': bearerToken
      };
      // var response = await http.post(
      //   Uri.parse('${StorageService.getUrl()}/api/addressData/update/$dataId'), 
      //   headers: headers,
      //   body: body
      //   );
      var request = http.Request('POST', Uri.parse('${StorageService.getUrl()}/api/addressData/update/$dataId'));
      request.body = json.encode(body);
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      // TODO better error handling
      if (response.statusCode == 200) {
        
        final respStr = await response.stream.bytesToString();
        final jsonBody = json.decode(respStr);
        return {"success" : true, "result": jsonBody};
      } else {
        return {"success" : false};
      }
  }

}