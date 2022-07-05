import 'dart:convert';

import 'package:dashbord/pages/main_menu.dart';
import 'package:dashbord/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:dashbord/urlapi.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/register.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginState extends State<Login> {
  bool _isLoading = true;
  //variabel global
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //membuat variabel umum pada form
  final LoginStatus _loginStatus = LoginStatus.notSignIn;
  String email, password;
  String roleAdmin = 'admin';
  String roleUser = 'user';
  //variabel global pada form
  final _key = GlobalKey<FormState>();
  bool _securityText = true; //password show hide

  //show hide password
  showHide() {
    setState(
      () {
        _securityText = !_securityText;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _getApiKey();
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      login();
    }
  }

  Future<void> _getApiKey() async {
    final prefs =
        await SharedPreferences.getInstance(); // inisialisasi sharedpref

    // Apabila api key ada maka langsung masuk ke main menu
    if (prefs.get('api_key') != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainMenuPage(),
        ),
      );
    }

    // Ubah loading menjadi false
    setState(() {
      _isLoading = false;
    });
  }

  // function login
  Future<void> login() async {
    final response = await http.post(Uri.parse(LoginUrl.login),
        body: {"email": email, "password": password});
    final data = jsonDecode(response.body);

    // Inisialisasi
    String message = data['message'];
    String accessToken = data['access_token'];

    // Kondisi apabila status code 200 / berhasil
    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();

      setState(() {
        prefs.setString("api_key", accessToken);
      });

      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainMenuPage(),
        ),
      );
    } else {
      _showToast(message, Colors.red);
    }
  }

  _showToast(String toast, Color backgroundColor) {
    final snackBar = SnackBar(
      content: Text(toast),
      backgroundColor: backgroundColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          key: _scaffoldKey,
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: edge,
                ),
                child: Column(
                  children: [
                    Form(
                      key: _key,
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 508,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 140.0,
                                    top: 20.0,
                                  ),
                                  child: Text(
                                    'Login Page',
                                    style: regularTextStyle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 30.0,
                                    right: 30.0,
                                    top: 40.0,
                                  ),
                                  child: TextFormField(
                                    //validator disini
                                    validator: (e) {
                                      if (e.isEmpty) {
                                        return 'isi email anda';
                                      }

                                      return null;
                                    },
                                    style: blackTextStyle,
                                    onSaved: (e) => email = e,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: blackColor,
                                          width: 1.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: blackColor,
                                        ),
                                      ),
                                      labelText: 'Email',
                                      labelStyle: blackTextStyle,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 30.0,
                                    right: 30.0,
                                    top: 40.0,
                                  ),
                                  child: TextFormField(
                                    //validator disini
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'isikan password';
                                      }

                                      return null;
                                    },
                                    style: blackTextStyle,
                                    obscureText: _securityText,
                                    onSaved: (value) => password = value,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: blackColor,
                                          width: 1.0,
                                        ),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black12,
                                        ),
                                      ),
                                      labelText: 'Password',
                                      labelStyle: blackTextStyle,
                                      suffixIcon: IconButton(
                                        color: Colors.black,
                                        onPressed: showHide,
                                        icon: Icon(
                                          _securityText
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 60.0),
                                  width: 260.0,
                                  child: ElevatedButton(
                                    onPressed: _isLoading
                                        ? null
                                        : () {
                                            check();
                                          },
                                    style: ElevatedButton.styleFrom(
                                      primary: _isLoading
                                          ? Colors.grey
                                          : Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        ),
                                      ),
                                    ),
                                    child:
                                        Text(_isLoading ? 'Loading' : 'Login'),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Register()),
                                    );
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      width: 200.0,
                                      child: const Center(
                                        child: Text('Mendaftar'),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      case LoginStatus.signIn:
        return const MainMenuPage();
    }
  }
}
