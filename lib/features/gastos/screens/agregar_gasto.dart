import 'package:flutter/material.dart';
import 'package:gasto_0/core/widgets/input.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:gasto_0/features/auth/providers/auth_provider.dart';

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
  bool _saving = false;

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
              const SizedBox(height: 20),
              _saving
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        final descripcion = descripcionController.text;
                        final monto = montoController.text;
                        final fecha = fechaController.text;
                        final categoria = _selectedValueOfCategory;

                        if (descripcion.isEmpty ||
                            monto.isEmpty ||
                            fecha.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Completa todos los campos')),
                          );
                          return;
                        }

                        setState(() {
                          _saving = true;
                        });
                        final authProvider =
                            Provider.of<AuthProvider>(context, listen: false);
                        final token = await authProvider.getToken();
                        final response = await http.post(
                          Uri.parse(
                              'http://localhost:3000/api/gastos/agregar_gasto'),
                          headers: {
                            'Content-Type': 'application/json',
                            'Authorization': 'Bearer $token',
                          },
                          body: jsonEncode({
                            'descripcion': descripcion,
                            'monto': double.tryParse(monto) ?? 0,
                            'fecha': fecha,
                            'categoria': categoria,
                          }),
                        );

                        //print('STATUS: ${response.statusCode}');
                        //print('BODY: ${response.body}');

                        setState(() {
                          _saving = false;
                        });

                        if (response.statusCode == 200 ||
                            response.statusCode == 201) {
                          Navigator.pop(
                              context); 
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Error al agregar gasto: ${response.body}')),
                          );
                        }
                      },
                      child: const Text('Agregar Gasto'),
                    ),
            ],
          ),
        ),
      ),
      //floatingActionButton: FloatingActionButton(
        //onPressed: () async {
          //await Navigator.pushNamed(context, '/agregar_gasto');
          //setState(() {});
        //},
        //child: const Icon(Icons.add_circle_outline),
      //),
    );
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
              items: const [
                DropdownMenuItem(
                  value: 'comida',
                  child: Text('Comida'),
                ),
                DropdownMenuItem(
                  value: 'transporte',
                  child: Text('Transporte'),
                ),
              ],
              onChanged: (String? newValue) {
                setState(() {
                  _selectedValueOfCategory = newValue!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
