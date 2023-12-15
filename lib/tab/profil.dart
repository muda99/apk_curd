import 'dart:convert';

import 'package:apk_curd/login.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  Future profil() async {
    final prefs = await SharedPreferences.getInstance();

    var id_user = (prefs.get('usr_id'));
    final Response = await http.post(
        Uri.parse("http://103.157.97.200/swamedika/api/profil.php"),
        body: {
          "userId": "5695096khj",
        });

    setState(() {
      if (Response.body == null) {
        print(Response.body);
      } else {
        var profil = jsonDecode(Response.body);
        _userName = profil[0]["nama_user"] ?? "";
        _userPhone = profil[0]["no_hp"] ?? "";
        nameController.text = profil[0]["nama_user"] ?? "";
        phoneController.text = profil[0]["no_hp"] ?? "";
      }
      // gambar = datajson[0]['faskes_foto'];
    });
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Future Editprofil() async {
    final prefs = await SharedPreferences.getInstance();

    var id_user = (prefs.get('usr_id'));
    final Response = await http
        .post(Uri.parse("http://103.157.97.200/swamedika/api/edit.php"), body: {
      "userId": "5695096khj",
      "nama_user": nameController.text,
      "no_hp": phoneController.text,
    });
    var profil = jsonDecode(Response.body);
    setState(() {
      if (Response.body == null) {
        print(Response.body);
      } else {}
      // gambar = datajson[0]['faskes_foto'];
    });
  }

  String _userName = "";
  String _userPhone = "";
  @override
  void initState() {
    profil();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil Pengguna"),
      ),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(
                        'https://as1.ftcdn.net/v2/jpg/01/92/07/76/1000_F_192077668_hLewzaqBcb2RVB0iiHmjYjnbZAUGJgOq.jpg'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    _userName,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Nomor Telepon: $_userPhone",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _showEditProfileDialog(context);
                    },
                    child: Text("Edit Profil"),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.remove('usr_id');

                      // Navigator.pop(context);
                      // Navigator.push(
                      //     context, SlidePageRoute(page: SignIn()));

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => SignIn()),
                          (route) => false);
                      // Aksi ketika tombol "Keluar" ditekan
                    },
                    child: Text("Keluar"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditProfileDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Profil"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Nama"),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: "Nomor Telepon"),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Batal"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("Simpan"),
              onPressed: () {
                setState(() {
                  print(phoneController.text);
                  Editprofil();
                  profil();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
