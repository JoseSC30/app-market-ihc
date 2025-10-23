import 'package:flutter/material.dart';

class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen'),
        backgroundColor: const Color(0xFF318066), 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'resumen de pedidos ...',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            // agregar un ListView
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Producto ${index + 1}'),
                    subtitle: Text('Descripción del producto'),
                    trailing: Text('\$${(index + 1) * 10}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
