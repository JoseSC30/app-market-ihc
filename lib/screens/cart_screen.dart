import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import 'configE_screen.dart';
import 'configT_screen.dart';
import 'orderSummary_screen.dart'; 


class CartScreen extends StatefulWidget {
  final List<CartItem> cartItems;

  const CartScreen({super.key, required this.cartItems});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<CartItem> cartItems;
  final TextEditingController discountController = TextEditingController();
  String deliveryType = 'En Físico';
  String paymentMethod = 'Efectivo';

  @override
  void initState() {
    super.initState();
    cartItems = widget.cartItems
        .map((item) => CartItem(product: item.product, quantity: item.quantity))
        .toList();
  }

  void updateQuantity(int index, String value) {
    final newQuantity = int.tryParse(value) ?? 0;
    setState(() {
      if (newQuantity <= 0) {
        cartItems.removeAt(index);
      } else {
        cartItems[index].quantity = newQuantity;
      }
    });
  }

  double get totalCart =>
      cartItems.fold(0, (sum, item) => sum + (item.quantity * item.product.price));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tu Carrito'),
        backgroundColor: const Color(0xFF318066),
      ),
      body: Column(
        children: [
          // 🛒 LISTA DE PRODUCTOS
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: cartItems.isEmpty
                  ? Center(
                      child: Text(
                        'El carrito de compras está vacío 🛒',
                        style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                      ),
                    )
                  : Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              // Encabezado
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                                  ),
                                ),
                                child: const Row(
                                  children: [
                                    Expanded(flex: 3, child: Text('Producto', style: TextStyle(fontWeight: FontWeight.bold))),
                                    Expanded(flex: 1, child: Text('Cant.', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
                                    Expanded(flex: 2, child: Text('P. Unit', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
                                    Expanded(flex: 1, child: Text('Desc', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
                                    Expanded(flex: 2, child: Text('Total', textAlign: TextAlign.end, style: TextStyle(fontWeight: FontWeight.bold))),
                                  ],
                                ),
                              ),

                              // Lista de productos
                              SizedBox(
                                height: 250, // altura controlada
                                child: ListView.builder(
                                  itemCount: cartItems.length,
                                  itemBuilder: (context, index) {
                                    final item = cartItems[index];
                                    final controller =
                                        TextEditingController(text: item.quantity.toString());
                                    final totalPrice = item.quantity * item.product.price;

                                    return Container(
                                      padding: const EdgeInsets.symmetric(vertical: 4),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(color: Colors.grey.shade200),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Text(item.product.name,
                                                overflow: TextOverflow.ellipsis, maxLines: 1),
                                          ),

                                          // Cantidad editable
                                          Expanded(
                                            flex: 1,
                                            child: TextField(
                                              controller: controller,
                                              textAlign: TextAlign.center,
                                              keyboardType: TextInputType.number,
                                              style: const TextStyle(fontSize: 14),
                                              decoration: const InputDecoration(
                                                isDense: true,
                                                contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                                                border: OutlineInputBorder(),
                                              ),
                                              onChanged: (value) => updateQuantity(index, value),
                                            ),
                                          ),

                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              '\$${item.product.price.toStringAsFixed(2)}',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(fontSize: 14),
                                            ),
                                          ),

                                          const Expanded(
                                            flex: 1,
                                            child: Text('\$0',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 14)),
                                          ),

                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              '\$${totalPrice.toStringAsFixed(2)}',
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        //  TOTAL GENERAL DEBAJO DEL CONTENEDOR
                        Container(
                          margin: const EdgeInsets.only(top: 12),
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total General:',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '\$${totalCart.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF318066),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),

          // SECCIÓN FIJA INFERIOR (códigos, tipo entrega, método, botón)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Tipo de entrega + botón "Config. Entrega"
                Row(
                  children: [
                    const Text(
                      'Tipo de entrega: ',
                      style: TextStyle(fontSize: 13),
                    ),
                    const SizedBox(width: 6),
                    SizedBox(
                      width: 90,
                      height: 28,
                      child: DropdownButtonFormField<String>(
                        value: deliveryType,
                        items: const [
                          DropdownMenuItem(value: 'En Físico', child: Text('En Físico')),
                          DropdownMenuItem(value: 'Delivery', child: Text('Delivery')),
                        ],
                        onChanged: (value) => setState(() => deliveryType = value!),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
                          ),
                        ),
                        style: const TextStyle(fontSize: 13, color: Colors.black),
                      ),
                    ),

                    // Botón "Config. Entrega" visible solo si elige "Delivery"
                    if (deliveryType == 'Delivery') ...[
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () async {
                          final result = await showDialog<String>(
                            context: context,
                            builder: (context) => const ConfigEScreen(),
                          );
                          if (result != null) {
                            // Aquí puedes manejar la ubicación seleccionada
                            print('Ubicación seleccionada: $result');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade300,
                          foregroundColor: Colors.black,
                          padding:
                              const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Config. Entrega',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: 6),

                // Método de pago + botón "Config. Tarjeta"
                Row(
                  children: [
                    const Text(
                      'Método de Pago:',
                      style: TextStyle(fontSize: 13),
                    ),
                    const SizedBox(width: 6),
                    SizedBox(
                      width: 90,
                      height: 28,
                      child: DropdownButtonFormField<String>(
                        value: paymentMethod,
                        items: const [
                          DropdownMenuItem(value: 'Efectivo', child: Text('Efectivo')),
                          DropdownMenuItem(value: 'Tarjeta', child: Text('Tarjeta'))
                          // DropdownMenuItem(value: 'Transferencia', child: Text('Transferencia')),
                        ],
                        onChanged: (value) => setState(() => paymentMethod = value!),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
                          ),
                        ),
                        style: const TextStyle(fontSize: 13, color: Colors.black),
                      ),
                    ),

                    // Botón "Config. Tarjeta" visible solo si elige "Tarjeta"
                    if (paymentMethod == 'Tarjeta') ...[
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ConfigTScreen()),
                        );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade300,
                          foregroundColor: Colors.black,
                          padding:
                              const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Config. Tarjeta',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: 25),

                // Botón "Siguiente"
                Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (cartItems.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('El carrito está vacío')),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OrderSummaryScreen(),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E3131),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Siguiente',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                  ),
                ],
              ),



              
            ],
          ),
        ), 
        ],
      ),
    );
  }
} 