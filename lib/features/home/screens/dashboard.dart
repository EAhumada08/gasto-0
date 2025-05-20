import 'package:flutter/material.dart';
import 'package:gasto_0/Models/user.dart';
import 'package:gasto_0/features/auth/providers/auth_provider.dart';
import 'package:gasto_0/features/home/data.dart';
import 'package:gasto_0/features/home/widgets/drawer_menu.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DateTime _date = DateTime.now();

  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025, 12),
      helpText: 'Selecciona una fecha',
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      drawer: drawerMenu(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Filtrar por fecha: '),
                      IconButton(
                        onPressed: _selectDate,
                        icon: Icon(Icons.filter_list_alt),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Agregar Gasto: '),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/agregar_gasto');
                        },
                        icon: Icon(Icons.add_circle_outline),
                      ),
                    ],
                  )
                ],
              ),
              PaginatedDataTable(
                  header: const Text('Gastos'),
                  rowsPerPage: 5,
                  columns: [
                    DataColumn(label: Text('Descripcion')),
                    DataColumn(label: Text('Monto')),
                    DataColumn(label: Text('Categoria')),
                    DataColumn(label: Text('Fecha')),
                  ],
                  source: DataSource(context)),
              const SizedBox(height: 20),
              FutureBuilder(
                  future: authProvider.getUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    if (snapshot.hasError) {
                      return const Text('Error al cargar el usuario');
                    }

                    final User? user = snapshot.data;
                    return Text(user?.name ?? 'Usuario no encontrado',
                        style: const TextStyle(fontSize: 20));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
