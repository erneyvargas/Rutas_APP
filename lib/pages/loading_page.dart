import 'package:flutter/material.dart';
import 'package:rutas_app/helpers/helpers.dart';
import 'package:rutas_app/pages/mapa_page.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Ejecuta circularProgresIndicator hasta que se construye el widget future
      body: FutureBuilder(
        future: this.checkGpsLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          );
        },
      ),
    );
  }

// Valida si tiene los permisos activos
  Future checkGpsLocation(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 1000));
    // Navega a la pagina sin poder devolverse
    Navigator.pushReplacement(context, navegarMapaFadeIn(context, MapaPage()));
  }
}