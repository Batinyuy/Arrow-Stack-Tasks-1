import 'package:flutter/material.dart';
import '../products_data.dart';
import '../product.dart';
import 'home_page.dart';
import 'cart_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  Map<int, int> cart = {};

  int get cartItemCount => cart.values.fold(0, (sum, q) => sum + q);
  double get cartTotal {
    double total = 0;
    cart.forEach((id, qty) {
      final p = products.firstWhere((e) => e.id == id);
      total += p.price * qty;
    });
    return total;
  }

  void addToCart(Product product) {
    setState(() => cart[product.id] = (cart[product.id] ?? 0) + 1);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${product.name} added to cart'), duration: const Duration(seconds: 1)));
  }

  void increaseQuantity(int id) => setState(() => cart[id] = (cart[id] ?? 0) + 1);
  void decreaseQuantity(int id) {
    setState(() {
      if (cart[id] != null) {
        if (cart[id]! > 1) cart[id] = cart[id]! - 1;
        else cart.remove(id);
      }
    });
  }

  void removeFromCart(int id) => setState(() => cart.remove(id));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shop With Us', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)), backgroundColor: Colors.white),
      body: selectedIndex == 0 ? HomePage(onAddToCart: addToCart) : CartPage(cart: cart, cartItemCount: cartItemCount, cartTotal: cartTotal, onIncrease: increaseQuantity, onDecrease: decreaseQuantity, onRemove: removeFromCart),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (i) => setState(() => selectedIndex = i),
        selectedItemColor: const Color(0xFF6750A4),
        items: [const BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'), BottomNavigationBarItem(icon: const Icon(Icons.shopping_cart_outlined), label: 'Cart ($cartItemCount)')],
      ),
    );
  }
}