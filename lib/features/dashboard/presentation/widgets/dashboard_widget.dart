import 'package:flutter/material.dart';
import 'dashboard_card_widget.dart';
import '../pages/crear_tarima_screen.dart';
import '../../domain/entities/client_model.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key});

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // List of clients
  final List<Client> _clients = [
    Client(id: '1', name: 'Oscar'),
    Client(id: '2', name: 'Daniel'),
  ];

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  void _crearTarima() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CrearTarimaScreen(clients: _clients)),
    );
  }

  void _agregarDescontarProductos() {
    _showDialog('Agregar y Descontar Productos',
        'Funcionalidad de agregar y descontar productos pendiente por implementar');
  }

  void _verReportes() {
    _showDialog(
        'Reportes', 'Funcionalidad de reportes pendiente por implementar');
  }

  void _organizarUsuarios() {
    _showDialog('Organizar Usuarios',
        'Funcionalidad de organizar usuarios pendiente por implementar');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Menu',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            _buildDrawerItem(Icons.add_business, 'Crear Tarima', _crearTarima),
            _buildDrawerItem(Icons.inventory, 'Agregar y Descontar Productos',
                _agregarDescontarProductos),
            _buildDrawerItem(Icons.file_copy, 'Reportes', _verReportes),
            const Spacer(),
            _buildDrawerItem(
                Icons.people, 'Organizar Usuarios', _organizarUsuarios),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        color: Colors.grey[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 24.0, bottom: 24.0),
              child: Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                children: [
                  Center(
                    child: DashboardCardWidget(
                      title: 'Cliente Oscar',
                      description: 'Info de Oscar',
                      onTap: () => _scaffoldKey.currentState?.openDrawer(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: DashboardCardWidget(
                      title: 'Cliente Daniel',
                      description: 'Info de Daniel',
                      onTap: () => _scaffoldKey.currentState?.openDrawer(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
