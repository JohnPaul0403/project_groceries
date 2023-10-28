import 'dart:convert';
import 'package:app/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:app/global/enviroments.dart';

final String _url = '${Environment.urlApp}';
final String _endPoint = 'get_login';

Future<dynamic> loginService(
  String username,
  String password,
) async {
  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('$_url$_endPoint'));
  request.body = json.encode({
    "username": "$username",
    "password": "$password"
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var resp = json.decode(await response.stream.bytesToString());
    if (resp['code'] == "00") {
      return {
        "status": true,
        "resp": User.fromJson(resp["user_info"]),
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
