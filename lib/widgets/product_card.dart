import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final Function(Product, int) onQuantityChanged; 

  const ProductCard({
    super.key,
    required this.product,
    required this.onQuantityChanged,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int quantity = 0;

  IconData _getProductIcon() {
    switch (widget.product.category.toLowerCase()) {
      case 'alimentos':
        if (widget.product.name.toLowerCase().contains('leche')) return Icons.local_drink;
        if (widget.product.name.toLowerCase().contains('pan')) return Icons.bakery_dining;
        if (widget.product.name.toLowerCase().contains('aceite')) return Icons.opacity;
        if (widget.product.name.toLowerCase().contains('arroz')) return Icons.rice_bowl;
        return Icons.fastfood;
      case 'bebidas':
        return Icons.local_cafe;
      case 'limpieza':
        return Icons.cleaning_services;
      case 'higiene':
        return Icons.soap;
      case 'hogar':
        return Icons.home;
      case 'mascotas':
        return Icons.pets;
      default:
        return Icons.shopping_bag;
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen del producto
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.green.shade100,
                        Colors.green.shade50,
                      ],
                    ),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: Center(
                    child: widget.product.imageUrl.isNotEmpty
                        ? ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            child: Image.asset(
                              widget.product.imageUrl,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Icon(
                            _getProductIcon(),
                            size: 60,
                            color: Colors.green.shade400,
                          ),
                  ),
                ),
                if (product.isFeatured)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Destacado',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Información del producto
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),

                  // Rating
                  Row(
                    children: [
                      Icon(Icons.star, size: 12, color: Colors.amber.shade700),
                      const SizedBox(width: 2),
                      Text(
                        '${product.rating}',
                        style: const TextStyle(fontSize: 11),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '(${product.reviews})',
                        style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  //  Precio + Selector de cantidad
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),

                      //  Selector de cantidad
                      Container(
                        height: 28,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.remove, size: 16),
                              onPressed: () {
                                if (quantity > 0) {
                                  setState(() => quantity--);
                                  widget.onQuantityChanged(product, quantity);
                                }
                              },
                            ),
                            Text(
                              quantity.toString(),
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.add, size: 16),
                              onPressed: () {
                                setState(() => quantity++);
                                widget.onQuantityChanged(product, quantity);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

