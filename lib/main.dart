import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rutas_app/bloc/busqueda/busqueda_bloc.dart';
import 'package:rutas_app/bloc/mapa/mapa_bloc.dart';
import 'package:rutas_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:rutas_app/pages/acceso_gps_page.dart';
import 'package:rutas_app/pages/loading_page.dart';
import 'package:rutas_app/pages/mapa_page.dart';
import 'package:rutas_app/pages/test_marker_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // bloc que hace referncia a todo lo relacionado a la ubicacion
        BlocProvider(create: (_) => MiUbicacionBloc()),
        BlocProvider(create: (_) => MapaBloc()),
        BlocProvider(create: (_) => BusquedaBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        // home: LoadingPage(),
        home: TestMarkerPage(),
        routes: {
          'mapa': (_) => MapaPage(),
          'loading': (_) => LoadingPage(),
          'acceso_pgs': (_) => AccesoGpsPage(),
        },
      ),
    );
  }
}
