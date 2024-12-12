import 'package:flutter/material.dart';
import '../models/client_model.dart';
import 'formulario_screen.dart';

class CrearTarimaScreen extends StatefulWidget {
  final List<Client> clients;

  const CrearTarimaScreen({super.key, required this.clients});

  @override
  _CrearTarimaScreenState createState() => _CrearTarimaScreenState();
}

class _CrearTarimaScreenState extends State<CrearTarimaScreen> {
  Client? _selectedClient;
  final ValueNotifier<bool> _isExpandedNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Tarima'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Seleccionar Cliente',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ExpansionCard(
                  initiallyExpanded: false,
                  title: _selectedClient != null
                      ? Text(_selectedClient!.name)
                      : const Text('Seleccionar cliente'),
                  isExpandedNotifier: _isExpandedNotifier,
                  children: [
                    for (final client in widget.clients)
                      ListTile(
                        title: Text(client.name),
                        onTap: () {
                          setState(() {
                            _selectedClient = client;
                            _isExpandedNotifier.value =
                                false; // Para cerrar la barra
                          });
                        },
                      ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
          Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                double buttonSize =
                    constraints.maxWidth * 0.2; // 20% del ancho de la pantalla
                return SizedBox(
                  width: buttonSize,
                  height: buttonSize,
                  child: FloatingActionButton(
                    onPressed: () {
                      if (_selectedClient == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Por favor, selecciona un cliente'),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 1),
                          ),
                        );
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FormularioScreen(client: _selectedClient!),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.add,
                      size: 80, // Icono grande
                    ),
                    backgroundColor: Colors.blue,
                    shape: CircleBorder(),
                    foregroundColor: Colors.white,
                    elevation: 6.0,
                    tooltip: 'Crear Tarima',
                    heroTag: null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ExpansionCard extends StatefulWidget {
  final Widget title;
  final List<Widget> children;
  final bool initiallyExpanded;
  final ValueNotifier<bool> isExpandedNotifier;

  const ExpansionCard({
    super.key,
    required this.title,
    required this.children,
    this.initiallyExpanded = false,
    required this.isExpandedNotifier,
  });

  @override
  _ExpansionCardState createState() => _ExpansionCardState();
}

class _ExpansionCardState extends State<ExpansionCard> {
  @override
  void initState() {
    super.initState();
    widget.isExpandedNotifier.value = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                widget.isExpandedNotifier.value =
                    !widget.isExpandedNotifier.value;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.title,
                  ValueListenableBuilder<bool>(
                    valueListenable: widget.isExpandedNotifier,
                    builder: (context, isExpanded, child) {
                      return Icon(
                        isExpanded
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: widget.isExpandedNotifier,
            builder: (context, isExpanded, child) {
              return isExpanded
                  ? Column(children: widget.children)
                  : Container();
            },
          ),
        ],
      ),
    );
  }
}
