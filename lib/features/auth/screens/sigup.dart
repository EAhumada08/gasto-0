import 'package:flutter/material.dart';
import 'package:gasto_0/features/auth/widgets/input_login.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 50,
          children: [
            Text(
              'Registrate',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                Inputlogin(label: 'Nombre', controller: nombreController),
                Inputlogin(label: 'Apellidos', controller: apellidoController),
                Inputlogin(label: 'Correo', controller: correoController),
                Inputlogin(
                  label: 'Contraseña',
                  controller: passwordController,
                  isPassword: true,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Ya tienes cuenta? '),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Inicia sesión'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
