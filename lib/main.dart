
import 'package:flutter/material.dart';

void main() {
  runApp(const ShopWithUsApp());
}

// ==========================================
// 1. PRODUCT MODEL
// ==========================================

class Product {
  final int id;
  final String name;
  final String category;
  final double price;
  final String image;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.image,
  });
}

// ==========================================
// 2. SAMPLE PRODUCT DATA
// ==========================================

const List<Product> products = [
  Product(
    id: 1,
    name: 'Wireless Headphones',
    category: 'Electronics',
    price: 25000,
    image:
    'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600',
  ),
  Product(
    id: 2,
    name: 'Smart Watch',
    category: 'Electronics',
    price: 35000,
    image:
    'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600',
  ),
  Product(
    id: 3,
    name: 'Running Shoes',
    category: 'Fashion',
    price: 28000,
    image:
    'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600',
  ),
  Product(
    id: 4,
    name: 'Backpack',
    category: 'Fashion',
    price: 18000,
    image:
    'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=600',
  ),
  Product(
    id: 5,
    name: 'Digital Camera',
    category: 'Electronics',
    price: 95000,
    image:
    'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=600',
  ),
  Product(
    id: 6,
    name: 'Sunglasses',
    category: 'Fashion',
    price: 12000,
    image:
    'https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=600',
  ),
  Product(
    id: 7,
    name: 'Coffee Maker',
    category: 'Home',
    price: 42000,
    image:
    'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=600',
  ),
  Product(
    id: 8,
    name: 'Modern Lamp',
    category: 'Home',
    price: 22000,
    image:
    'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=600',
  ),
];

// ==========================================
// 3. MAIN APPLICATION
// ==========================================

class ShopWithUsApp extends StatelessWidget {
  const ShopWithUsApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ShopEase',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F7FB),
      ),
      home: const MainScreen(),
    );
  }
}

// ==========================================
// 4. MAIN SCREEN AND CART STATE
// ==========================================

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  // Selected bottom navigation tab.
  int selectedIndex = 0;

  // Stores product IDs and their quantities.
  Map<int, int> cart = {};

  // Selected product category.
  String selectedCategory = 'All';

  // Calculate total number of items.
  int get cartItemCount {
    return cart.values.fold(0, (sum, quantity) => sum + quantity);
  }

  // Calculate total cart price.
  double get cartTotal {
    double total = 0;

    cart.forEach((productId, quantity) {
      final product = products.firstWhere(
            (item) => item.id == productId,
      );

      total += product.price * quantity;
    });

    return total;
  }

  // Add product to cart.
  void addToCart(Product product) {
    setState(() {
      cart[product.id] = (cart[product.id] ?? 0) + 1;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to cart'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // Increase product quantity.
  void increaseQuantity(int productId) {
    setState(() {
      cart[productId] = (cart[productId] ?? 0) + 1;
    });
  }

  // Decrease product quantity.
  void decreaseQuantity(int productId) {
    setState(() {
      if (cart[productId] != null) {
        if (cart[productId]! > 1) {
          cart[productId] = cart[productId]! - 1;
        } else {
          cart.remove(productId);
        }
      }
    });
  }

  // Remove product completely.
  void removeFromCart(int productId) {
    setState(() {
      cart.remove(productId);
    });
  }

  // Format prices using FCFA.
  String formatPrice(double price) {
    return '${price.toStringAsFixed(0)} FCFA';
  }

  @override
  Widget build(BuildContext context) {

    final List<Widget> pages = [
      buildHomePage(),
      buildCartPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shop With Us',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(
                  Icons.shopping_bag_outlined,
                  size: 28,
                ),
                if (cartItemCount > 0)
                  Positioned(
                    right: -8,
                    top: -8,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                      child: Text(
                        '$cartItemCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),

      body: pages[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        selectedItemColor: const Color(0xFF6750A4),
        unselectedItemColor: Colors.grey,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_cart_outlined),
            activeIcon: const Icon(Icons.shopping_cart),
            label: 'Cart ($cartItemCount)',
          ),
        ],
      ),
    );
  }

  // ==========================================
  // 5. HOME PAGE
  // ==========================================

  Widget buildHomePage() {

    final categories = [
      'All',
      'Electronics',
      'Fashion',
      'Home',
    ];

    final filteredProducts = selectedCategory == 'All'
        ? products
        : products
        .where((product) =>
    product.category == selectedCategory)
        .toList();

    return Column(
      children: [

        // Search and welcome section.
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Discover Products',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Find the best products for you.',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 18),

              TextField(
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  // Search can be implemented here.
                },
              ),
            ],
          ),
        ),

        // Product categories.
        SizedBox(
          height: 48,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];

              final isSelected =
                  selectedCategory == category;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ChoiceChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                  selectedColor: const Color(0xFF6750A4),
                  labelStyle: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : Colors.black87,
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 12),

        // Product grid.
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {

              final columns =
              constraints.maxWidth > 700 ? 4 : 2;

              return GridView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: filteredProducts.length,
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.62,
                ),
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];

                  return buildProductCard(product);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  // ==========================================
  // 6. PRODUCT CARD
  // ==========================================

  Widget buildProductCard(Product product) {

    return Card(
      color: Colors.white,
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      size: 45,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  product.category,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  formatPrice(product.price),
                  style: const TextStyle(
                    color: Color(0xFF6750A4),
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => addToCart(product),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      const Color(0xFF6750A4),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                    ),
                    child: const Text('Add to Cart'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // 7. SHOPPING CART PAGE
  // ==========================================

  Widget buildCartPage() {

    if (cart.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 85,
              color: Colors.grey,
            ),

            SizedBox(height: 16),

            Text(
              'Your cart is empty',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              'Add some products to get started.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [

        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: cart.entries.map((entry) {

              final product = products.firstWhere(
                    (item) => item.id == entry.key,
              );

              final quantity = entry.value;

              return Card(
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 14),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [

                      // Product image.
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          product.image,
                          width: 85,
                          height: 85,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 85,
                              height: 85,
                              color: Colors.grey.shade200,
                              child: const Icon(Icons.image),
                            );
                          },
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Product information.
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [

                            Text(
                              product.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              formatPrice(product.price),
                              style: const TextStyle(
                                color: Color(0xFF6750A4),
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Row(
                              children: [

                                // Decrease quantity.
                                IconButton(
                                  onPressed: () =>
                                      decreaseQuantity(product.id),
                                  icon: const Icon(
                                    Icons.remove_circle_outline,
                                  ),
                                  constraints: const BoxConstraints(),
                                  padding: EdgeInsets.zero,
                                ),

                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Text(
                                    '$quantity',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                // Increase quantity.
                                IconButton(
                                  onPressed: () =>
                                      increaseQuantity(product.id),
                                  icon: const Icon(
                                    Icons.add_circle_outline,
                                  ),
                                  constraints: const BoxConstraints(),
                                  padding: EdgeInsets.zero,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Remove product.
                      IconButton(
                        onPressed: () =>
                            removeFromCart(product.id),
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        // Cart total and checkout.
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Items',
                    style: TextStyle(fontSize: 16),
                  ),

                  Text(
                    '$cartItemCount',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Amount',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    formatPrice(cartTotal),
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFF6750A4),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Checkout is not yet connected to a payment service.',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6750A4),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Proceed to Checkout',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
