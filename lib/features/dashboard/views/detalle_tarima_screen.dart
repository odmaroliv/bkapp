import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

class DetalleTarimaScreen extends StatefulWidget {
  const DetalleTarimaScreen({super.key});

  @override
  _DetalleTarimaScreenState createState() => _DetalleTarimaScreenState();
}

class _DetalleTarimaScreenState extends State<DetalleTarimaScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _codigoController = TextEditingController();

  Future<void> _scanBarcode() async {
    try {
      var result = await BarcodeScanner.scan();
      setState(() {
        _codigoController.text = result.rawContent;
      });
    } catch (e) {
      _showErrorSnackBar('Error escaneando el código de barras: $e');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  String? _validateField(String? value, String errorMessage) {
    return (value == null || value.isEmpty) ? errorMessage : null;
  }

  void _handleFormSubmission() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tarima creada exitosamente'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      _showErrorSnackBar('Llena todos los campos');
    }
  }

  @override
  void dispose() {
    _codigoController.dispose();
    super.dispose();
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isScanner = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.grey[200],
        suffixIcon: isScanner
            ? IconButton(
                icon: const Icon(Icons.camera_alt),
                onPressed: _scanBarcode,
              )
            : null,
      ),
      validator: (value) => _validateField(value, 'Por favor, ingresa $label'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Tarima'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              _buildTextField('Número de tarima', TextEditingController()),
              const SizedBox(height: 20),
              _buildTextField('Código de barras', _codigoController,
                  isScanner: true),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleFormSubmission,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Crear Tarima',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
