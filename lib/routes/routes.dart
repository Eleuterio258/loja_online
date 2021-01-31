import 'package:flutter/material.dart';
import 'package:login_firebase/pages/base/base_page.dart';
import 'package:login_firebase/pages/login/login_page.dart';
import 'package:login_firebase/pages/signup/signup_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'base': (_) => BasePage(),
  'signup': (_) => SignupPage(),
  'login': (_) => LoginPage(),
};
