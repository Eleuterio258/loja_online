import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login_firebase/contents/url_base.dart';

class AuthServiceDb extends ChangeNotifier {
  Future<void> regiter(
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
}
