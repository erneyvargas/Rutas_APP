part of 'widgets.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if (state.seleccionManual) {
          return Container();
        } else {
          return buildSearchbar(context);
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
            final resultado = await showSearch(
                context: context, delegate: SearchDestination());
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

  void retornoBusqueda(BuildContext context, SerachResult result) {
    print("Cancelo: ${result.cancelo}");
    print("Manual: ${result.manual}");
    if (result.cancelo) return;

    if (result.manual) {
      context.read<BusquedaBloc>().add(OnActivarMarcadorManual());
      //BlocProvider.of<BusquedaBloc>(context).add(OnActivarMarcadorManual());
    }
  }
}
