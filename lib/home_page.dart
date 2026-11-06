import 'package:flutter/material.dart';
import '../products_data.dart';
import '../product.dart';
import '../product_card.dart';
import 'product_detail_page.dart';

class HomePage extends StatefulWidget {
  final Function(Product) onAddToCart;
  const HomePage({super.key, required this.onAddToCart});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'All';
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final categories = ['All', 'Electronics', 'Fashion', 'Home'];
    final filtered = products.where((p) {
      final matchCat = selectedCategory == 'All' || p.category == selectedCategory;
      final matchSearch = p.name.toLowerCase().contains(searchQuery.toLowerCase());
      return matchCat && matchSearch;
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Discover Products', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              const Text('Tap a product to see details.', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(hintText: 'Search products...', prefixIcon: const Icon(Icons.search), filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none)),
                onChanged: (v) => setState(() => searchQuery = v),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 48,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final cat = categories[index];
              final isSelected = selectedCategory == cat;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ChoiceChip(label: Text(cat), selected: isSelected, onSelected: (_) => setState(() => selectedCategory = cat), selectedColor: const Color(0xFF6750A4), labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black87)),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: filtered.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 0.62),
            itemBuilder: (context, index) {
              final product = filtered[index];
              return ProductCard(
                product: product,
                onAddToCart: () => widget.onAddToCart(product),
                onTap: () {
                  // LINK TO DETAIL PAGE
                  Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailPage(product: product, onAddToCart: widget.onAddToCart)));
                },
              );
            },
          ),
        ),
      ],
    );
  }
}