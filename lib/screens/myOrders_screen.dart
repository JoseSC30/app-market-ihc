import 'package:flutter/material.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo de pedidos
    final List<Map<String, dynamic>> orders = [
      {
        'id': 'PEDIDO 1',
        'status': 'Entregado',
        'total': 105.00,
        'color': Colors.grey.shade200,
      },
      {
        'id': 'PEDIDO 2',
        'status': 'Entregado',
        'total': 105.00,
        'color': Colors.grey.shade200,
      },
      {
        'id': 'PEDIDO3',
        'status': 'Entregado',
        'total': 105.00,
        'color': Colors.grey.shade200,
      },
      {
        'id': 'PEDIDO 4',
        'status': 'En camino',
        'total': 105.00,
        'color': const Color(0xFFB8E6D5),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Pedidos'),
        backgroundColor: const Color(0xFF318066),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: order['color'],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order['id'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Estado: ${order['status']}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: ${order['total'].toStringAsFixed(2)} Bs.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Aquí se puede navegar a los detalles del pedido
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(order['id']),
                            content: Text(
                              'Estado: ${order['status']}\nTotal: ${order['total'].toStringAsFixed(2)} Bs.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cerrar'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text(
                        'ver mas',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
