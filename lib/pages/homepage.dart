import 'package:dashbord/auth/login.dart';
import 'package:dashbord/pages/main_menu.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int value;
  String role;

  void _getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
      role = preferences.getString("role");
    });
  }

  @override
  void initState() {
    // getData();
    _getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (role == 'klien') {
      return const Login();
    }

    return const MainMenuPage();
  }
}
