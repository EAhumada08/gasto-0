import 'package:flutter/material.dart';
import 'package:gasto_0/core/widgets/input.dart';

class AgregarGasto extends StatefulWidget {
  const AgregarGasto({super.key});

  @override
  State<AgregarGasto> createState() => _AgregarGastoState();
}

class _AgregarGastoState extends State<AgregarGasto> {
  String _selectedValueOfCategory = 'comida';
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  Input(
                      label: 'Descripcion', controller: descripcionController),
                  categoryDropDownButton(),
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
                ],
              ),
              SizedBox(
                height: 20,
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

  void _verDatos() {
    print('Descripcion: ${descripcionController.text}');
    print('Categoria: $_selectedValueOfCategory');
    print('Monto: ${montoController.text}');
    print('Fecha: ${fechaController.text}');
  }

  Widget categoryDropDownButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categoria',
          style: Theme.of(context).primaryTextTheme.labelMedium,
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: _selectedValueOfCategory,
              items: [
                DropdownMenuItem(
                  value: 'comida',
                  child: Text('Comida'),
                ),
                DropdownMenuItem(
                  value: 'transporte',
                  child: Text('Transporte'),
                ),
              ],
              onChanged: ((String? newValue) {
                setState(() {
                  _selectedValueOfCategory = newValue!;
                });
              }),
            ),
          ),
        ),
      ],
    );
  }
}
