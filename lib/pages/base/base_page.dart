import 'package:flutter/material.dart';
import 'package:login_firebase/components/drawer_components.dart';
import 'package:login_firebase/pages/login/login_page.dart';
import 'package:login_firebase/utils/page_management.dart';
import 'package:provider/provider.dart';

class BasePage extends StatelessWidget {
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManagement(pageController),
      child: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Scaffold(appBar: AppBar(), drawer: DrawerComponents()),
          LoginPage(),
          Container(color: Colors.blue),
          Container(color: Colors.brown),
        ],
      ),
    );
  }
}
