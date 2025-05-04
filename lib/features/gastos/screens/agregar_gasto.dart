import 'package:flutter/material.dart';
import 'package:gasto_0/core/widgets/input.dart';

class AgregarGasto extends StatelessWidget {
  AgregarGasto({super.key});

  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController fechaController = TextEditingController();
  final TextEditingController montoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Gasto'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 20,
            children: [
              Input(label: 'Descripcion', controller: descripcionController),
              DropdownMenu(initialSelection: 'Comida', dropdownMenuEntries: [
                DropdownMenuEntry<String>(
                  label: 'Comida',
                  value: 'Comida',
                ),
                DropdownMenuEntry<String>(
                  label: 'Transporte',
                  value: 'Transporte',
                ),
                DropdownMenuEntry<String>(
                  label: 'Entretenimiento',
                  value: 'Entretenimiento',
                ),
              ]),
              Input(
                label: 'Monto',
                controller: montoController,
                icono: Icons.attach_money,
              ),
              Input(
                label: 'Fecha',
                controller: fechaController,
                icono: Icons.calendar_month,
              ),
              ElevatedButton(
                onPressed: () {
                  // Lógica para agregar gasto
                },
                child: const Text('Agregar Gasto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
