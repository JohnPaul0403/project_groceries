import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app/global/enviroments.dart';

final String _url = '${Environment.urlApp}';
final String _endPoint = 'add_products';

Future<dynamic> addProductService(
  String name,
  String price,
  String amount
) async {
  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('$_url$_endPoint'));
  request.body = json.encode({
    "username": "user_1",
    "name": name,
    "price": price,
    "amount": amount
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var resp = json.decode(await response.stream.bytesToString());
    print(resp);
    if (resp['code'] == "00") {
      return {
        "status": true,
        "resp": resp["message"],
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