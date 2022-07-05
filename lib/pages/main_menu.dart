import 'dart:convert';

import 'package:dashbord/auth/login.dart';
import 'package:dashbord/pages/history/history.dart';
import 'package:dashbord/pages/service_order/service_order.dart';
import 'package:dashbord/pages/service_requirements/service_requirements.dart';
import 'package:dashbord/themes/themes.dart';
import 'package:dashbord/urlapi.dart';
import 'package:dashbord/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({Key key}) : super(key: key);

  @override
  _MainMenuPageState createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  String apiKey;

  @override
  void initState() {
    super.initState();
    getApiKey();
  }

  void getApiKey() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      apiKey = prefs.get('api_key');
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        // Gambar ats Png
        children: <Widget>[
          Container(
            height: size.height * 3,
            decoration: const BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage('assets/images/top_header.png'),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  // Avatar
                  FutureBuilder(
                      future: _getProfile(),
                      builder: (_, snapshot) {
                        if (snapshot.hasData &&
                            snapshot.connectionState == ConnectionState.done) {
                          return Row(
                            children: [
                              Initicon(
                                backgroundColor: Colors.green,
                                size: 100.0,
                                text: snapshot.data['nama_klien'] ?? '-',
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data['nama_klien'] ?? '-',
                                    style:
                                        whiteTextStyle.copyWith(fontSize: 16.0),
                                  ),
                                  Text(
                                    snapshot.data['email'] ?? '-',
                                    style:
                                        whiteTextStyle.copyWith(fontSize: 16.0),
                                  ),
                                ],
                              ),
                              Flexible(
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.logout,
                                      color: whiteColor,
                                    ),
                                    onPressed: () async {
                                      // Logout
                                      await http.get(
                                          Uri.parse(ProfileUrl.logout),
                                          headers: {
                                            'Content-Type': 'application/json',
                                            'Accept': 'application/json',
                                            'Authorization': 'Bearer $apiKey',
                                          });

                                      // Inisialisasi shared pref
                                      final prefs =
                                          await SharedPreferences.getInstance();

                                      // Clear api key
                                      prefs.clear();

                                      // Navigasi ke login page
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const Login(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          );
                        }

                        return const CircularProgressIndicator();
                      }),
                  const SizedBox(
                    height: 25.0,
                  ),
                  // Content
                  Expanded(
                    child: GridView.count(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      primary: false,
                      crossAxisCount: 2,
                      children: <Widget>[
                        //  card Pemesanan Layanan
                        ItemCard(
                            onTap: () {
                              _showLoading();

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const ServiceOrderPage()));
                            },
                            iconData: Icons.shopping_basket,
                            title: "Pemesanan"),
                        ItemCard(
                            onTap: () {
                              _showLoading();

                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const ServiceRequirementsPage(),
                              ));
                            },
                            iconData: Icons.info,
                            title: "Persyaratan"),
                        ItemCard(
                            onTap: () {
                              _showLoading();

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const HistoryPage()));
                            },
                            iconData: Icons.history,
                            title: "Riwayat"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showLoading() async {
    SmartDialog.showLoading(
        backDismiss: false,
        background: whiteColor,
        widget: const LoadingCard());
  }

  Future<void> _getProfile() async {
    final response =
        // await http.get(Uri.parse('http://192.168.161.93:8000/api/pelayanan'));
        await http.get(Uri.parse(ProfileUrl.profile), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $apiKey',
    });

    return json.decode(response.body);
  }
}
