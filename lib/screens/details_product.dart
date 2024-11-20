import 'package:flutter/material.dart';
import 'package:pec_mobile/models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.fields.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.fields.name,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              "Description:",
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(product.fields.description),
            const SizedBox(height: 16.0),
            Text(
              "Price:",
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text("Rp ${product.fields.price}"),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Kembali ke halaman daftar produk
              },
              child: const Text('Back to Product List'),
            ),
          ],
        ),
      ),
    );
  }
}
