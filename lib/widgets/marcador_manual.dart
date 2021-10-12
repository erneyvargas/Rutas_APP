part of 'widgets.dart';

class MarcadorManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if (state.seleccionManual) {
          return _BuildMarcadorManual();
        } else {
          return Container();
        }
      },
    );
  }
}

class _BuildMarcadorManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        // Boton Regresar
        Positioned(
          top: 50,
          left: 20,
          child: FadeInLeft(
            duration: Duration(milliseconds: 150),
            child: CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black87,
                ),
                onPressed: () {
                  context
                      .read<BusquedaBloc>()
                      .add(OnDesactivarMarcadorManual());
                },
              ),
            ),
          ),
        ),

        Center(
          child: Transform.translate(
            offset: Offset(0, -12),
            child: BounceInDown(child: Icon(Icons.location_on, size: 50)),
          ),
        ),
        // Boton confirmar destino
        Positioned(
          bottom: 50,
          left: 40,
          child: FadeIn(
            child: MaterialButton(
              minWidth: width - 120,
              child: Text("Confirmar Destino",
                  style: TextStyle(color: Colors.white)),
              color: Colors.black,
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              onPressed: () {
                this.caclularDestino(context);
              },
            ),
          ),
        )
      ],
    );
  }

  void caclularDestino(BuildContext context) async {
    final trafficService = new TrafficService();
    final inicio = context.read<MiUbicacionBloc>().state.ubicacion;
    final destino = context.read<MapaBloc>().state.ubicacionCentral;

    final trafficResponse =
        await trafficService.geoCoordsInicioDestino(inicio, destino);

    final points = trafficResponse.routes[0].legs[0].steps;

    final distancia = trafficResponse.routes[0].legs[0].distance;
    final duracion = trafficResponse.routes[0].legs[0].duration;

    final List<LatLng> rutasCoords = points
        .map(
            (point) => LatLng(point.startLocation.lat, point.startLocation.lng))
        .toList();

    print(duracion);
    //final duracion = trafficResponse.
  }
}
