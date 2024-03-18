

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:salt/services/storage_service.dart';

class AuthService {

    Future<bool> login(String email, String password) async {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
             
      var request = http.Request('POST', Uri.parse('${StorageService.getUrl()}/api/login'));
      request.body = json.encode({
        "password": "Iamtestingyou456",
        "email": "wyndhammorland@gmail.com"        
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        final jsonBody = json.decode(respStr);
        StorageService().write("Bearer", jsonBody["access_token"]);
        return true;
      }
      else {
        return false;
      }

    } 

    Future<String> getBearerAuth() async {
      String? bearerToken = await StorageService().readSecureData("bearer");
      return "Bearer $bearerToken";
    }
}