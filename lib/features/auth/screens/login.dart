import 'package:flutter/material.dart';
import 'package:gasto_0/features/auth/widgets/input_login.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              Text(
                'Gasto 0',
                style: Theme.of(context).primaryTextTheme.titleLarge,
              ),
              Text('Bienvenido',
                  style: Theme.of(context).primaryTextTheme.titleMedium),
              Inputlogin(label: 'Usuario', controller: _userController),
              Inputlogin(
                  label: 'Contraseña',
                  isPassword: true,
                  controller: _passwordController),
              ElevatedButton(
                onPressed: () {
                  print(_passwordController.text);
                  _passwordController.clear();
                  _userController.clear();
                },
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.all(15)),
                  backgroundColor:
                      WidgetStatePropertyAll(Theme.of(context).primaryColor),
                ),
                child: Text(
                  'Ingresar',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
