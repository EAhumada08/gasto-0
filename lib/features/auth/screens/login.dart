import 'package:flutter/material.dart';
import 'package:gasto_0/features/auth/providers/auth_provider.dart';
import 'package:gasto_0/features/auth/screens/sigup.dart';
import 'package:gasto_0/features/auth/widgets/input_login.dart';
import 'package:gasto_0/features/home/screens/dashboard.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController userController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          textAlign: TextAlign.center,
          'Gasto 0',
          style: Theme.of(context).primaryTextTheme.titleLarge,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 20,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              spacing: 40,
              children: [
                Inputlogin(
                    label: 'Usuario',
                    icono: Icons.person,
                    controller: userController),
                Inputlogin(
                    label: 'Contraseña',
                    isPassword: true,
                    icono: Icons.lock,
                    controller: passwordController),
              ],
            ),
            if (authProvider.errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  authProvider.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            authProvider.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      final success = await authProvider.login(
                        userController.text.trim(),
                        passwordController.text.trim(),
                      );

                      if (success && mounted) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Dashboard()));
                      }
                      print(passwordController.text);
                      passwordController.clear();
                      userController.clear();
                    },
                    style: ButtonStyle(
                      padding: WidgetStatePropertyAll(EdgeInsets.all(15)),
                      backgroundColor: WidgetStatePropertyAll(
                          Theme.of(context).primaryColor),
                    ),
                    child: Text(
                      'Ingresar',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('¿Olvidaste tu contraseña?',
                    style: Theme.of(context).primaryTextTheme.labelMedium),
                TextButton(
                  child: Text('Recuperar'),
                  onPressed: () {},
                )
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('¿No tienes cuenta?',
                    style: Theme.of(context).primaryTextTheme.labelMedium),
                TextButton(
                  child: Text('Registrate'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
