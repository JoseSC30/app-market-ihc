import 'package:flutter/material.dart';

class ConfigTScreen extends StatefulWidget {
  const ConfigTScreen({Key? key}) : super(key: key);

  @override
  State<ConfigTScreen> createState() => _ConfigTScreenState();
}

class _ConfigTScreenState extends State<ConfigTScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _codigoController = TextEditingController();
  bool guardarTarjeta = false;

  @override
  void dispose() {
    _nombreController.dispose();
    _numeroController.dispose();
    _fechaController.dispose();
    _codigoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos de la Tarjeta'),
        backgroundColor: const Color(0xFF318066),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.only(bottom: 80),
                children: [
                  // Imagen de Visa y Mastercard
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 16),
                      Image.asset('assets/tarjetas.png', width: 120),
                      const SizedBox(width: 16),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Nombre del titular
                  const Text('Nombre del titular de la tarjeta',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextFormField(
                    controller: _nombreController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Color(0xFF318066)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Color(0xFF318066)),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingresa el nombre del titular';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // Número de tarjeta
                  const Text('Nro de Tarjeta', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextFormField(
                    controller: _numeroController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Color(0xFF318066)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Color(0xFF318066)),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Ingresa el número de tarjeta';
                      final numero = value.replaceAll(' ', '');
                      if (numero.length != 16) return 'Número de tarjeta inválido';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // Fecha de expiración
                  const Text('Fecha de expiración (MM/AA)',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextFormField(
                    controller: _fechaController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Color(0xFF318066)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Color(0xFF318066)),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Ingresa la fecha de expiración';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // Código de seguridad
                  const Text('Código de seguridad (CVV)',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextFormField(
                    controller: _codigoController,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Color(0xFF318066)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Color(0xFF318066)),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Ingresa el código de seguridad';
                      if (value.length < 3) return 'Código de seguridad inválido';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // Checkbox
                  CheckboxListTile(
                    title: const Text('Quiero guardar esta tarjeta para mi próxima compra'),
                    value: guardarTarjeta,
                    onChanged: (value) {
                      setState(() => guardarTarjeta = value ?? false);
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Botón en esquina inferior derecha
          Positioned(
            bottom: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Datos guardados')),
                  );
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E3131),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Aceptar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
