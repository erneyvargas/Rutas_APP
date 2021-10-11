part of 'widgets.dart';

class MarcadorManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        // Boton Regresar
        Positioned(
          top: 50,
          left: 20,
          child: CircleAvatar(
            maxRadius: 25,
            backgroundColor: Colors.white,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black87,
              ),
              onPressed: () {
                // hacer algo
              },
            ),
          ),
        ),

        Center(
          child: Transform.translate(
            offset: Offset(0, -12),
            child: Icon(Icons.location_on, size: 50),
          ),
        ),
        // Boton confirmar destino
        Positioned(
          bottom: 50,
          left: 40,
          child: MaterialButton(
            minWidth: width - 120,
            child: Text("Confirmar Destino",
                style: TextStyle(color: Colors.white)),
            color: Colors.black,
            shape: StadiumBorder(),
            elevation: 0,
            splashColor: Colors.transparent,
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
