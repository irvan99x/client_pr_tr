// IMPORTANT THIS IS DEAD CODE, DONT USE IT


// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class DatabaseHelper {
//   String serverUrl = 'http://192.168.161.93:8000/public/api/';
//   //add data Order
//   void adddata(String order, String file) async {
//     final prefs = await SharedPreferences.getInstance();

//     String url =
//         'https://backendadmapi.alamanahalislami.com/public/api/addorder';
//     //passing ke backend
//     // "https://192.168.53.93/api/addorder";
//     http.post(Uri.parse(url), body: {"order": "$order", "file": "$file"}).then(
//         (response) {
//       print('Response Status: ${response.statusCode}');
//       print('isi Reponse bodynya : ${response.body}');
//     });
//   }

//   //get data pelayanan
//   Future getDataPelayanan() async{
//     String url =
//     "https://backendadmapi.alamanahalislami.com/api/pelayanan";
//     // "https://192.168.53.93/api/pelayanan";
//     http.Response response = await http.get(Uri.parse(url));
//     return json.decode(response.body);
//   }
// }
