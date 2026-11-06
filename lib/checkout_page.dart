import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  final double total;
  final int itemCount;
  const CheckoutPage({super.key, required this.total, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.check_circle, size: 80, color: Colors.green),
            const SizedBox(height: 20),
            Text('You have $itemCount items', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Total: ${total.toStringAsFixed(0)} USD', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Back to Cart'))),
          ],
        ),
      ),
    );
  }
}