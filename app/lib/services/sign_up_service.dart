import 'dart:convert';
import 'package:app/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:app/global/enviroments.dart';

final String _url = '${Environment.urlApp}';
final String _endPoint = 'sign_up';

Future<dynamic> signUpService(
  String name,
  String email,
  String username,
  String password,
) async {
  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('$_url$_endPoint'));
  request.body = json.encode({
    "name": "$name",
    "email": "$email",
    "username": "$username",
    "password": "$password",
    "items" : []
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var resp = json.decode(await response.stream.bytesToString());
    if (resp['code'] == "00") {
      return {
        "status": true,
        "resp": "success"
      };
    } else {
      return {
        "status": false,
        "resp": null,
        "message": resp["message"] ?? 'Data not found'
      };
    }
  }
  else {
    return {
      "status": false,
      "resp": "Connection error",
      "message": 'Data not found'
    };
  }
}