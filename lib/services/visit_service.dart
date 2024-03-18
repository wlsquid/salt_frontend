import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:salt/services/auth.dart';
import 'package:salt/services/storage_service.dart';

class VisitService {
  
  Future<Map> addAVisit(Map body) async {
      final String bearerToken = await AuthService().getBearerAuth();
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': bearerToken
    };
    var request = http.Request('POST', Uri.parse('http://127.0.0.1:8000/api/visit/add'));
    request.body = json.encode(body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

   if (response.statusCode == 200) {        
    final respStr = await response.stream.bytesToString();
    final jsonBody = json.decode(respStr);
    return {"success" : true, "result": jsonBody};
    } else {
      return {"success" : false};
    }

  }
  
  // Future<Map> updateAVisit(int visitId, Map body) async {

  // }
  
  // Future<Map> updateAVisit(Map body) async {
    
  // }
}