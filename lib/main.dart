import 'package:flutter/material.dart';
import 'features/dashboard/presentation/widgets/dashboard_widget.dart'; // Importamos el archivo del Dashboard desde su nueva ubicación

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardWidget(), // Llamamos el DashboardWidget como home
    );
  }
}
