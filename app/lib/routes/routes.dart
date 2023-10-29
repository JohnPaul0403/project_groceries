import 'package:app/pages/add_grocery_page.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/pages/launch_page.dart';
import 'package:app/pages/login_page.dart';
import 'package:app/pages/page_404.dart';
import 'package:app/pages/signup_page.dart';
import 'package:app/pages/update_page.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext context)> getApplicationRoutes() {
  return <String, Widget Function(BuildContext context)> {
    "launch_page" : (BuildContext context) => LaunchPage(),
    "login_page" : (BuildContext context) => LoginPage(),
    "update_page" : (BuildContext context) => UpdatePage(),
    "home_page" : (BuildContext context) => HomePage(),
    "page_404" : (BuildContext context) => Page404Page(),
    "signup_page" : (BuildContext context) => SignUpPage(),
    "add_product_page" : (BuildContext context) => AddGroceryPage(),
  };
}