import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TransaksiTeb extends StatefulWidget {
  @override
  _TransaksiTebState createState() => _TransaksiTebState();
}

class _TransaksiTebState extends State<TransaksiTeb> {
  List products = [];
  Future Orderhistory() async {
    final prefs = await SharedPreferences.getInstance();

    var id_user = (prefs.get('usr_id'));
    final Response = await http.post(
        Uri.parse("http://103.157.97.200/swamedika/api/transaksi.php"),
        body: {
          "userId": "5695096khj",
        });

    setState(() {
      if (Response.body == "null") {
        print(Response.body);
      } else {
        products = jsonDecode(Response.body);
      }
      // gambar = datajson[0]['faskes_foto'];
    });
  }

  String transaksi_id = "";

  Future del() async {
    final Response = await http
        .post(Uri.parse("http://103.157.97.200/swamedika/api/dell.php"), body: {
      "transaksi_id": transaksi_id,
    });

    setState(() {
      if (Response.body == null) {
        print(Response.body);
      } else {}
      // gambar = datajson[0]['faskes_foto'];
    });
  }

  @override
  void initState() {
    Orderhistory();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Transaksi"),
      ),
      body: ListView.builder(
        itemCount: products == null ? 0 : products.length,
        itemBuilder: (ctx, index) {
          final transaction = products[index];
          final transaksiId = transaction["transaksi_id"];
          final namaBarang = transaction["nama_barang"];
          final hargaBarang = int.tryParse(transaction["harga_barang"] ?? "0");
          final picBarang = transaction["pic_barang"];
          final jumlahBarang =
              int.tryParse(transaction["jumlah_barang"] ?? "0");

          final totalHarga = hargaBarang! * jumlahBarang!;
          final formattedHarga = NumberFormat.currency(
            locale: 'id_ID',
            symbol: 'Rp',
          ).format(hargaBarang);

          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              leading: Image.network(
                picBarang,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              title: Text(namaBarang),
              subtitle: Text(
                  "ID Transaksi: $transaksiId\nTotal Harga: $formattedHarga"),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    transaksi_id = transaction["transaksi_id"];
                    del();
                    Orderhistory();
                    _hapusTransaksi(index);
                  });

                  // Tambahkan logika hapus transaksi di sini
                },
                icon: Icon(Icons.delete), // Menggunakan ikon tempat sampah
              ),
            ),
          );
        },
      ),
    );
  }

  void _hapusTransaksi(int index) {
    setState(() {});

    // Menampilkan AlertDialog untuk notifikasi berhasil hapus
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Transaksi Berhasil Dihapus"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Orderhistory();
                Navigator.of(context).pop();
                Orderhistory();
                Orderhistory();

                // Menutup dialog
              },
              child: Text("Tutup"),
            ),
          ],
        );
      },
    );
  }
}
