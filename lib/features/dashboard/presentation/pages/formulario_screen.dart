import 'package:flutter/material.dart';
import '../../domain/entities/client_model.dart';
import 'detalle_tarima_screen.dart';

class FormularioScreen extends StatefulWidget {
  final Client client;

  const FormularioScreen({super.key, required this.client});

  @override
  _FormularioScreenState createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedFechaEntrada;
  final TextEditingController _dateEntradaController = TextEditingController();

  Future<void> _selectDate(BuildContext context, DateTime? initialDate,
      ValueChanged<DateTime> onDateSelected) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      onDateSelected(picked);
    }
  }

  String? _validateField(String? value, String errorMessage) {
    return (value == null || value.isEmpty) ? errorMessage : null;
  }

  Widget _buildDropdownField(String label, List<String> items) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      items: items.map((item) {
        return DropdownMenuItem(value: item, child: Text(item));
      }).toList(),
      onChanged: (value) {},
      validator: (value) =>
          _validateField(value, 'Por favor, selecciona $label'),
    );
  }

  Widget _buildTextField(String label,
      {bool isDate = false,
      DateTime? date,
      TextEditingController? controller}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        filled: true,
        fillColor: Colors.grey[200],
        suffixIcon: isDate
            ? IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _selectDate(context, date, (selectedDate) {
                  setState(() {
                    controller?.text =
                        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                    if (label == 'Fecha Entrada') {
                      _selectedFechaEntrada = selectedDate;
                    }
                  });
                }),
              )
            : null,
      ),
      controller: controller,
      validator: (value) => _validateField(value, 'Por favor, ingresa $label'),
    );
  }

  List<Widget> _buildFormFields() {
    if (widget.client.name == 'Oscar') {
      return [
        _buildDropdownField(
            'Tipos', ['costal', 'barril', 'paquete', 'supersaco', 'caja']),
        const SizedBox(height: 20),
        _buildTextField('Numero de lote', controller: TextEditingController()),
        const SizedBox(height: 20),
        _buildTextField('Caducidad', controller: TextEditingController()),
        const SizedBox(height: 20),
        _buildTextField('Gramaje', controller: TextEditingController()),
        const SizedBox(height: 20),
        _buildTextField('Tipo Producto', controller: TextEditingController()),
      ];
    } else if (widget.client.name == 'Daniel') {
      return [
        _buildTextField('Codigo', controller: TextEditingController()),
        const SizedBox(height: 20),
        _buildTextField('Color', controller: TextEditingController()),
        const SizedBox(height: 20),
        _buildTextField('Cantidad artículos dentro de la caja',
            controller: TextEditingController()),
        const SizedBox(height: 20),
        _buildTextField(
          'Fecha Entrada',
          isDate: true,
          date: _selectedFechaEntrada,
          controller: _dateEntradaController,
        ),
      ];
    } else {
      return [const Text('No se ha seleccionado un cliente válido.')];
    }
  }

  void _handleFormSubmission() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DetalleTarimaScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Llena todos los campos'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.client.name == 'Oscar' ? 'Maltas' : 'Handbag'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Text(
                'Cliente: ${widget.client.name}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 16),
              Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10.0,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ..._buildFormFields(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _handleFormSubmission,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 40,
                  ),
                ),
                child: const Text(
                  'Armar nueva tarima',
                  style: TextStyle(
                    fontSize: 20,
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
