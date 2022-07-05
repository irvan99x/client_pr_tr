import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // final LoginStatus _loginStatus = LoginStatus.notSignIn;
  final _key = GlobalKey<FormState>();
  String email, name, password, alamat, nomorTelepon;

  //function register
  register() async {
    showDialog(context: context, builder: (context) => _loading(context));
    var url = "https://sellatugasakhir.com/api/klien/register";
    final response = await http.post(Uri.parse(url), body: {
      "email": email,
      "nama_klien": name,
      "password": password,
      "alamat": alamat,
      "no_telepon": nomorTelepon,
    });

    final data = jsonDecode(response.body);

    int value = data['value'];
    String message = data['message'];

    Navigator.pop(context);

    //kondisi
    if (value == 1) {
      _showToast(message, Colors.green);

      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
    } else if (value == 2) {
      //
    } else {
      _showToast(message, Colors.red);
    }
    // final data = jsonDecode(response.body);
    // int value = data['value'];
    // String message = data['message'];
    // //kondisi
    // if (value == 1) {
    //   Navigator.pop(context);
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => Login(),
    //     ),
    //   );
    //   print(message);
    // } else if (value == 2) {
    //   print(message);
    //   Navigator.pop(context);
    //   _showToast(message);
    // } else {
    //   print(message);
    //   _showToast(message);
    // }
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      register();
    }
  }

  _showToast(String toast, Color backgroundColor) {
    final snackBar = SnackBar(
      content: Text(toast),
      backgroundColor: backgroundColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _loading(BuildContext context) {
    return Transform.scale(
      scale: 1,
      child: const Opacity(
        opacity: 1,
        child: CupertinoAlertDialog(
            title: Text('Please wait...'),
            content: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: SizedBox(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            )),
      ),
    );
  }

  //show password
  bool _secureText = true;
  bool _secureTextConfirm = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  showHideConfirm() {
    setState(() {
      _secureTextConfirm = !_secureTextConfirm;
    });
  }

  final TextEditingController _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _key,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 13.0,
          ),
          child: Form(
            key: _key,
            child: SingleChildScrollView(
              primary: true,
              child: ListView(
                primary: false,
                shrinkWrap: true,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 140.0,
                      top: 20.0,
                    ),
                    child: Text(
                      'Register Page',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueGrey,
                        fontFamily: 'Times New Roman',
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
                      validator: (val) {
                        if (val.isEmpty) return 'Email Tidak Boleh Kosong';
                        return null;
                      },
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      //onsave
                      onSaved: (e) => email = e,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black12,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black12,
                          ),
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Colors.black12,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
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
                      validator: (val) {
                        if (val.isEmpty) return 'Nama Tidak Boleh Kosong';

                        return null;
                      },
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      //onsave
                      onSaved: (e) => name = e,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black12,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black12,
                          ),
                        ),
                        labelText: 'Nama',
                        labelStyle: TextStyle(
                          color: Colors.black12,
                        ),
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
                      controller: _pass,
                      //validator disini
                      validator: (val) {
                        if (val.isEmpty) return 'Password Tidak Boleh Kosong';
                        return null;
                      },
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      //onsave
                      onSaved: (e) => password = e,
                      obscureText: _secureText,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black12,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black12,
                          ),
                        ),
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                          color: Colors.black12,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            showHide();
                          },
                          icon: Icon(
                            _secureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                        focusColor: Colors.black45,
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
                      validator: (val) {
                        if (val.isEmpty) return 'Alamat Tidak Boleh Kosong';
                        return null;
                      },
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      //onsave
                      onSaved: (e) => alamat = e,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black12,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black12,
                          ),
                        ),
                        labelText: 'Alamat',
                        labelStyle: TextStyle(
                          color: Colors.black12,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 30.0,
                      right: 30.0,
                      top: 40.0,
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          //validator disini
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Nomor Telephone Tidak Boleh Kosong';
                            }

                            return null;
                          },
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          //onsave
                          onSaved: (e) => nomorTelepon = e,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black12,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black12,
                              ),
                            ),
                            labelText: 'Nomor Telephone',
                            labelStyle: TextStyle(
                              color: Colors.black12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //     left: 30.0,
                  //     right: 30.0,
                  //     top: 20.0,
                  //   ),
                  //   child: Column(
                  //     children: [
                  //       TextFormField(
                  //         onSaved: (e) => password = e,
                  //         controller: _confirmPass,
                  //         validator: (val) {
                  //           if (val.isEmpty)
                  //             return 'Password not match';
                  //           return null;
                  //         },
                  //         obscureText: _secureTextConfirm,
                  //         style: TextStyle(
                  //           color: Colors.redAccent,
                  //         ),
                  //         decoration: InputDecoration(
                  //           focusedBorder: OutlineInputBorder(
                  //             borderSide: BorderSide(
                  //               color: Colors.black12,
                  //             ),
                  //           ),
                  //           enabledBorder: OutlineInputBorder(
                  //             borderSide: BorderSide(
                  //               color: Colors.black12,
                  //               width: 1.0,
                  //             ),
                  //           ),
                  //           labelText: 'Confirmation Password',
                  //           labelStyle: TextStyle(
                  //             color: Colors.black12,
                  //           ),
                  //           suffixIcon: IconButton(
                  //             onPressed: () {
                  //               showHideConfirm();
                  //             },
                  //             icon: Icon(
                  //               _secureTextConfirm
                  //                   ? Icons.visibility_off
                  //                   : Icons.visibility,
                  //             ),
                  //           ),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  Container(
                    padding: const EdgeInsets.only(top: 60.0),
                    width: 260.0,
                    height: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        check();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                        ),
                      ),
                      child: const Text('Mendaftar'),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      width: 200.0,
                      child: const Center(
                        child: Text(
                          'Sudah memiliki akun!',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
