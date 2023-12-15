import 'package:apk_curd/beranda.dart';
import 'package:apk_curd/homepage.dart';
import 'package:apk_curd/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

String iduser = "";

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tobada',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
          future: _ambildata(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              );
            } else {
              return hometab();
            }
          }),
    );
  }
}

Future<void> _ambildata() async {
  final prefs = await SharedPreferences.getInstance();

  iduser = prefs.getString('usr_id') ?? '';
  print(iduser);
  // return iduser;
}
