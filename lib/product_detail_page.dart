import 'package:flutter/material.dart';
import '../product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  final Function(Product) onAddToCart;
  const ProductDetailPage({super.key, required this.product, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.image, width: double.infinity, height: 320, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.category, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 6),
                  Text(product.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('${product.price.toStringAsFixed(0)} USD', style: const TextStyle(fontSize: 22, color: Color(0xFF6750A4), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Text(product.description, style: const TextStyle(fontSize: 15, height: 1.5)),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity, height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        onAddToCart(product);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6750A4), foregroundColor: Colors.white),
                      child: const Text('Add to Cart'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}