import 'package:flutter/material.dart';
import 'package:gasto_0/features/auth/screens/login.dart';

Widget drawerMenu(BuildContext context) {
  return Drawer(
    child: SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Header',
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Inicio'),
                ),
                ListTile(
                  leading: Icon(Icons.format_list_bulleted_add),
                  title: Text('Agregar Gasto'),
                  onTap: () {
                    Navigator.pushNamed(context, '/agregar_gasto');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.pending_actions_outlined),
                  title: Text('Reportes'),
                ),
                ListTile(
                  leading: Icon(Icons.stacked_line_chart_sharp),
                  title: Text('Estadisticas'),
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/statistics',
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Configuracion'),
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Cerrar Sesion'),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                        (Route<dynamic> route) => false);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
