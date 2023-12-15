import 'package:apk_curd/tab/beranda_menu.dart';
import 'package:apk_curd/tab/profil.dart';
import 'package:apk_curd/tab/transaksi_tab.dart';
import 'package:flutter/material.dart';

class hometab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: TabBarView(
            children: [
              MyHomePage(),
              TransaksiTeb(),
              UserProfilePage(),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Theme.of(context).dividerColor),
              ),
            ),
            child: const TabBar(
              labelColor: Colors.blue, // Warna teks tab yang aktif
              unselectedLabelColor:
                  Colors.grey, // Warna teks tab yang tidak aktif
              indicatorColor: Colors.blue, // Warna garis bawah pada tab aktif
              tabs: [
                Tab(text: 'Beranda', icon: Icon(Icons.home)),
                Tab(text: 'Transaksi', icon: Icon(Icons.book)),
                Tab(text: 'Profil', icon: Icon(Icons.person)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
