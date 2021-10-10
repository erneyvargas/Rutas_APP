import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  @override
  void initState() {
    BlocProvider.of<MiUbicacionBloc>(context).iniciarSeguiminto();
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<MiUbicacionBloc>(context).cancelarSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Se dispara cada vez que la ubicacion Cambie con los nuevos datos del state
        child: BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
          builder: (_, state) => crearMapa(state),
        ),
      ),
    );
  }

  Widget crearMapa(MiUbicacionState state) {
    if (!state.existeUbicacion) {
      return Center(
        child: Text('Ubicando....'),
      );
    }
    final _cameraPosition = new CameraPosition(
      target: state.ubicacion,
      zoom: 15,
    );
    return GoogleMap(
      initialCameraPosition: _cameraPosition,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
    );
  }
}
