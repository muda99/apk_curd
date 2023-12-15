import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final List<Map<String, dynamic>> products = [
  //   {
  //     "name": "Produk 1",
  //     "imageUrl":
  //         "https://images.unsplash.com/photo-1586458995526-09ce6839babe?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=873&q=80",
  //     "price": 10.0,
  //   },
  //   {
  //     "name": "Produk 2",
  //     "imageUrl":
  //         "https://images.unsplash.com/photo-1586458995526-09ce6839babe?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=873&q=80",
  //     "price": 20.0,
  //   },
  //   // Tambahkan lebih banyak produk di sini
  // ];
  List products = [];
  Future Orderhistory() async {
    final Response = await http.post(
      Uri.parse("http://103.157.97.200/swamedika/api/list_bar.php"),
    );

    setState(() {
      if (Response.body == null) {
        print(Response.body);
      } else {
        products = jsonDecode(Response.body);
      }
      // gambar = datajson[0]['faskes_foto'];
    });
  }

  String id_barng = "";

  Future beli() async {
    final prefs = await SharedPreferences.getInstance();

    var id_user = (prefs.get('usr_id'));
    final Response = await http
        .post(Uri.parse("http://103.157.97.200/swamedika/api/sell.php"), body: {
      "userId": "5695096khj",
      "id_barang": id_barng,
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
        title: Text("Toba"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Poster berjalan otomatis
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 16 / 9,
                enlargeCenterPage: true,
              ),
              items: products.map((product) {
                return Image.network(
                  product["pic_barang"] ?? "",
                  fit: BoxFit.cover,
                );
              }).toList(),
            ),

            SizedBox(height: 16.0),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Daftar Produk",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: products == null ? 0 : products.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 3.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        products[index]["pic_barang"] ?? "",
                        height: 150.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          products[index]["nama_barang"] ?? "",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          products[index]["harga_barang"] ?? "",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showProductDetailDialog(context, products[index]);
                        },
                        child: Text("Lihat Detail"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showProductDetailDialog(
      BuildContext context, Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(product["nama_barang"] ?? ""),
          content: Container(
            width: 300.0, // Sesuaikan lebar sesuai preferensi Anda
            height: 190.0, //80 Sesuaikan tinggi sesuai preferensi Anda
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  product["pic_barang"] ?? "",
                  height: 150.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Harga: ${product["harga_barang"] ?? ""}",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Tambahkan informasi barang lainnya di sini jika diperlukan
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  id_barng = product["barang_id"] ?? "";
                  Navigator.of(context).pop();
                  // Tutup dialog
                  beli();
                  _showSuccessDialog(context, product);
                });

                // Tambahkan logika untuk membeli barang di sini
              },
              child: Text("Beli"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text("Tutup"),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context, Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.check_circle, // Icon yang digunakan (gunakan yang sesuai)
                color: Colors.green, // Warna ikon
                size: 36.0, // Ukuran ikon
              ),
              SizedBox(width: 10.0), // Spasi antara ikon dan teks
              Text("Transaksi Berhasil"),
            ],
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Terima kasih telah melakukan pembelian:"),
              SizedBox(height: 8.0),
              Text(product["nama_barang"] ?? ""),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text("Tutup"),
            ),
          ],
        );
      },
    );
  }
}
