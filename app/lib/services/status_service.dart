import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app/global/enviroments.dart';

final String _url = '${Environment.urlApp}';
final String _endPoint = 'get_status';

Future<dynamic> getStatusService() async {
  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('$_url$_endPoint'));
  request.body = json.encode({
    "code": Environment.status_code
  });
  request.headers.addAll(headers);

  late http.StreamedResponse response;
  try{
    response = await request.send();
  }catch(e) {
    return {
      "status": false,
      "resp": "Connection error",
      "message": 'System is not working'
    };
  }
  print(response.statusCode);

  if (response.statusCode == 200) {
    var resp = json.decode(await response.stream.bytesToString());
    if (resp['code'] == "00") {
      return {
        "status": true,
        "resp": "Operating",
        "app_version" : resp["app_version"]
      };
    } else {
      return {
        "status": false,
        "resp": null,
        "message": 'System is not working'
      };
    }
  }
  else {
    return {
      "status": false,
      "resp": "Connection error",
      "message": 'System is not working'
    };
  }
}
