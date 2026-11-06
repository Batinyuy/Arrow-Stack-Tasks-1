import 'package:flutter/material.dart';
import '../products_data.dart';
import 'checkout_page.dart';

class CartPage extends StatelessWidget {
  final Map<int, int> cart;
  final Function(int) onIncrease;
  final Function(int) onDecrease;
  final Function(int) onRemove;
  final int cartItemCount;
  final double cartTotal;

  const CartPage({super.key, required this.cart, required this.onIncrease, required this.onDecrease, required this.onRemove, required this.cartItemCount, required this.cartTotal});

  @override
  Widget build(BuildContext context) {
    if (cart.isEmpty) {
      return const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.shopping_cart_outlined, size: 85, color: Colors.grey), SizedBox(height: 16), Text('Your cart is empty', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold))]));
    }
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: cart.entries.map((entry) {
              final product = products.firstWhere((e) => e.id == entry.key);
              final qty = entry.value;
              return Card(
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 14),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.network(product.image, width: 85, height: 85, fit: BoxFit.cover)),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(height: 6), Text('${product.price.toStringAsFixed(0)} USD', style: const TextStyle(color: Color(0xFF6750A4), fontWeight: FontWeight.bold)), const SizedBox(height: 8), Row(children: [IconButton(onPressed: () => onDecrease(product.id), icon: const Icon(Icons.remove_circle_outline), constraints: const BoxConstraints(), padding: EdgeInsets.zero), Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Text('$qty', style: const TextStyle(fontWeight: FontWeight.bold))), IconButton(onPressed: () => onIncrease(product.id), icon: const Icon(Icons.add_circle_outline), constraints: const BoxConstraints(), padding: EdgeInsets.zero)])])),
                      IconButton(onPressed: () => onRemove(product.id), icon: const Icon(Icons.delete_outline, color: Colors.red)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Total Items'), Text('$cartItemCount', style: const TextStyle(fontWeight: FontWeight.bold))]),
              const SizedBox(height: 12),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Total Amount', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), Text('${cartTotal.toStringAsFixed(0)} USD', style: const TextStyle(fontSize: 18, color: Color(0xFF6750A4), fontWeight: FontWeight.bold))]),
              const SizedBox(height: 18),
              SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: () {
                // LINK TO CHECKOUT PAGE
                Navigator.push(context, MaterialPageRoute(builder: (_) => CheckoutPage(total: cartTotal, itemCount: cartItemCount)));
              }, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6750A4), foregroundColor: Colors.white), child: const Text('Proceed to Checkout'))),
            ],
          ),
        ),
      ],
    );
  }
}