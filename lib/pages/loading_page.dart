import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rutas_app/helpers/helpers.dart';
import 'package:rutas_app/pages/acceso_gps_page.dart';
import 'package:rutas_app/pages/mapa_page.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Ejecuta circularProgresIndicator hasta que se construye el widget future
      body: FutureBuilder(
        future: this.checkGpsLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Text(snapshot.data),
            );
          } else {
            return Center(child: CircularProgressIndicator(strokeWidth: 2));
          }
        },
      ),
    );
  }

// Valida si tiene los permisos activos
  Future checkGpsLocation(BuildContext context) async {
    // Verificar permisos de GPS
    final permisoGPS = await Permission.location.isGranted;

    // Valida si el GPS esta Activo
    final gpsActivo = await Geolocator().isLocationServiceEnabled();

    if (permisoGPS && gpsActivo) {
      Navigator.pushReplacement(
          context, navegarMapaFadeIn(context, MapaPage()));
    } else if (!permisoGPS) {
      Navigator.pushReplacement(
          context, navegarMapaFadeIn(context, AccesoGpsPage()));
      return 'Es necesario el permiso de GPS';
    } else {
      return 'Active el GPS';
    }
  }
}
