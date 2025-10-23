import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/category.dart';
import '../data/sample_data.dart';
import '../widgets/category_card.dart';
import '../widgets/product_card.dart';
import '../widgets/featured_banner.dart';
import '../models/cart_item.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Category> categories = [];
  List<Product> products = [];
  List<Product> featuredProducts = [];
  List<Product> filteredProducts = [];
  List<CartItem> cartItems = [];

  final TextEditingController _searchController = TextEditingController();

  void updateCart(Product product, int quantity) {
    setState(() {
      final index = cartItems.indexWhere((item) => item.product.id == product.id);

      if (quantity == 0 && index != -1) {
        cartItems.removeAt(index);
      } else if (index == -1 && quantity > 0) {
        cartItems.add(CartItem(product: product, quantity: quantity));
      } else if (index != -1) {
        cartItems[index].quantity = quantity;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    categories = SampleData.getCategories();
    products = SampleData.getProducts();
    featuredProducts = products.where((p) => p.isFeatured).toList();
    filteredProducts = List.from(products);

    _searchController.addListener(_filterProducts);
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      if (query.isEmpty) {
        filteredProducts = List.from(products);
      } else {
        filteredProducts = products.where((product) {
          return product.name.toLowerCase().contains(query) ||
              product.description.toLowerCase().contains(query) ||
              product.category.toLowerCase().contains(query);
        }).toList();
      }

      featuredProducts = filteredProducts.where((p) => p.isFeatured).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF318066),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'CompraYa!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Row(
              children: [
                Icon(Icons.location_on, size: 14, color: Colors.white.withOpacity(0.9)),
                const SizedBox(width: 4),
                Text(
                  'Enviar a: Tu ubicación',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(cartItems: cartItems),
                    ),
                  );
                },
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      cartItems.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 Barra de búsqueda
            Container(
              color: const Color(0xFF318066),
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Buscar productos...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Banner destacado
            const FeaturedBanner(),
            const SizedBox(height: 24),

            // 🏷️ Categorías
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categorías',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Ver todas',
                      style: TextStyle(color: Color(0xFF318066)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryCard(category: categories[index]);
                },
              ),
            ),
            const SizedBox(height: 24),

            // ⭐ Productos destacados
            if (featuredProducts.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Productos Destacados',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Ver más',
                        style: TextStyle(color: Color(0xFF318066)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 240,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: featuredProducts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 160,
                      margin: const EdgeInsets.only(right: 12),
                      child: ProductCard(
                        product: featuredProducts[index],
                        onQuantityChanged: updateCart,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],

            // 🛍️ Todos los productos
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Todos los Productos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            const SizedBox(height: 12),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: filteredProducts.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      child: Center(
                        child: Text(
                          'No se encontraron productos.',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.builder(
                        key: ValueKey(filteredProducts.length),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.65,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            product: filteredProducts[index],
                            onQuantityChanged: updateCart,
                          );
                        },
                      ),
                    ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF318066),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
