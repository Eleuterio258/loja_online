import 'dart:convert';

import 'package:http/http.dart' as http;

final url = "http://192.168.137.1/crud/crud-rest/users";
Future<void> adicionar(
    {username, password, email, firstname, lastname, address}) async {
  Map params = {
    "username": username,
    "password": password,
    "email": email,
    "first_name": firstname,
    "last_name": lastname,
    "address": address
  };

  var _body = json.encode(params);
  var header = {"Content-Type": "application/json"};

  var response = await http.post(url, headers: header, body: _body);

  print(response.body);
}
