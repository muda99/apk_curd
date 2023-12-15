import 'dart:convert';

import 'package:apk_curd/beranda.dart';
import 'package:apk_curd/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _showClearButton = false;
  bool showNotification = false;
  @override
  void initState() {
    super.initState();
  }

  //
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool checkBoxValue = false;
  _onChange(bool val) {
    setState(() {
      checkBoxValue = val;
    });
  }

  bool tep = false;
  Future _login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      showDialog<void>(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text("Pemberitahuan !!!"),
            content: Text("Akun data tidak benar!"),
            actions: <Widget>[
              TextButton(
                child: Text("Tutup"),
                onPressed: () {
                  Navigator.of(dialogContext)
                      .pop(); // Menutup dialog saat tombol ditekan
                },
              ),
            ],
          );
        },
      );
      return; // Optional, tergantung pada logika Anda
    }

    final Response = await http.post(
        Uri.parse("http://103.157.97.200/swamedika/api/login.php"),
        body: {
          "username": emailController.text,
          "password": passwordController.text
        });

    var datauser = jsonDecode(Response.body);

    if (datauser == false) {
      showDialog<void>(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text("Pemberitahuan !!!"),
            content: Text("Akun anda tidak terdaftar!"),
            actions: <Widget>[
              TextButton(
                child: Text("Tutup"),
                onPressed: () {
                  Navigator.of(dialogContext)
                      .pop(); // Menutup dialog saat tombol ditekan
                },
              ),
            ],
          );
        },
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => hometab(),
        ),
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setBool("isUser", true);
      prefs.setString("usr_id", datauser[0]['id_user']);

      return datauser;
    }
  }

  //============================================================================
  late MediaQueryData queryData;
  FocusNode usernameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return MediaQuery(
      data: queryData.copyWith(textScaleFactor: 1.0),
      child: SafeArea(
        child: Scaffold(
          body: Form(
            // key: _formKey,
            child: Container(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: 52,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: 35,
                  // ),

                  //Appbar
                  // Container(
                  //   height: 50,
                  //   child: Stack(
                  //     fit: StackFit.expand,
                  //     children: [
                  //       //back btn
                  //       Positioned.directional(
                  //         textDirection: Directionality.of(context),
                  //         start: -4,
                  //         top: 0,
                  //         bottom: 0,
                  //         child: InkWell(
                  //           onTap: () {
                  //             Navigator.pop(context);
                  //           },
                  //           child: Padding(
                  //             padding: const EdgeInsets.all(10.0),
                  //             child: Image.asset(
                  //               "assets/icons/ic_back.png",
                  //               scale: 30,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  //
                  Expanded(
                    child: Container(
                      child: ListView(
                        children: [
                          //Space
                          SizedBox(
                            height: 35,
                          ),
                          //Sign In

                          //Space
                          Column(
                            children: [
                              Text(
                                "Toba",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.green[900],
                                  fontSize: 100,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.10,
                                ),
                              ),
                              Text(
                                "Toko Serba Ada",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.green[900],
                                  fontSize: 23,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.10,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 35,
                          ),

                          //Space

                          //Email or Phone Number
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Stack(
                              children: [
                                TextFormField(
                                  controller: emailController,
                                  textInputAction: TextInputAction.next,
                                  focusNode: usernameFocusNode,
                                  onFieldSubmitted: (value) {
                                    // Fokus ke TextField selanjutnya
                                    FocusScope.of(context)
                                        .requestFocus(passwordFocusNode);
                                  },
                                  decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(top: 5, left: 14),
                                    labelText: "Input Username",
                                    labelStyle: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "medium",
                                        color: Colors.grey),
                                  ),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: "medium",
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          //Space
                          // SizedBox(
                          //   height: 17,
                          // ),
                          //Password Text Field

                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Stack(
                              children: [
                                TextFormField(
                                  obscureText: _obscureText,
                                  controller: passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  focusNode: passwordFocusNode,
                                  textInputAction: TextInputAction.next,
                                  onEditingComplete: () {},
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 14),
                                    labelText: "Input Password",
                                    labelStyle: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "medium",
                                        color: Colors.grey),
                                  ),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: "medium",
                                      color: Colors.black),
                                ),
                                Positioned.directional(
                                  textDirection: Directionality.of(context),
                                  end: 8,
                                  top: 4,
                                  child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _toggle();
                                        });
                                      },
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: _obscureText
                                              ? const Icon(
                                                  Icons.visibility_off,
                                                  color: Colors.grey,
                                                )
                                              : const Icon(
                                                  Icons.visibility_outlined,
                                                  color: Colors.grey,
                                                ))),
                                )
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text(
                                  "Forget Password?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xff6e5de7),
                                    fontSize: 12,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.06,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  MaterialButton(
                      onPressed: () async {
                        _login();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 340,
                              height: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.green[900],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Login",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.08,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),

                  SizedBox(
                    height: 25,
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
