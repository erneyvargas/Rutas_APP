part of 'widgets.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if (state.seleccionManual) {
          return Container();
        } else {
          return FadeInDown(child: buildSearchbar(context));
        }
      },
    );
  }

  Widget buildSearchbar(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        width: double.infinity,
        child: GestureDetector(
          onTap: () async {
            final proximedad = context.read<MiUbicacionBloc>().state.ubicacion;
            final resultado = await showSearch(
                context: context, delegate: SearchDestination(proximedad));
            this.retornoBusqueda(context, resultado);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            width: double.infinity,
            child: Text(
              "Dónde quieres ir?",
              style: TextStyle(color: Colors.black87),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 5))
                ]),
          ),
        ),
      ),
    );
  }

  Future retornoBusqueda(BuildContext context, SerachResult result) async {
    print("Cancelo: ${result.cancelo}");
    print("Manual: ${result.manual}");
    if (result.cancelo) return;

    if (result.manual) {
      context.read<BusquedaBloc>().add(OnActivarMarcadorManual());
      //BlocProvider.of<BusquedaBloc>(context).add(OnActivarMarcadorManual());
      return;
    }
    // Calcular la ruta en base al valor: Result
    calculandoAlerta(context);
    final trafficService = new TrafficService();
    final mapaBloc = context.read<MapaBloc>();

    final inicio = context.read<MiUbicacionBloc>().state.ubicacion;
    final destino = result.position;

    final drivingResponse =
        await trafficService.geoCoordsInicioDestino(inicio, destino);
    final points = drivingResponse.routes[0].legs[0].steps;

    final distancia = drivingResponse.routes[0].legs[0].distance.toString();
    final duracion = drivingResponse.routes[0].legs[0].duration.toString();

    final List<LatLng> rutasCoords = points
        .map(
            (point) => LatLng(point.startLocation.lat, point.startLocation.lng))
        .toList();
    mapaBloc.add(OnCrearRutaInicioDestino(rutasCoords, distancia, duracion));
    Navigator.of(context).pop();
  }
}
