part of 'busqueda_bloc.dart';

@immutable
class BusquedaState {
  final bool seleccionManual;
  final List<SerachResult> historial;

  BusquedaState({
    this.seleccionManual = false,
    List<SerachResult> historial,
  }) : this.historial = (historial == null) ? [] : historial;

  BusquedaState copyWith({
    bool seleccionManual,
    List<SerachResult> historial,
  }) =>
      BusquedaState(
        seleccionManual: seleccionManual ?? this.seleccionManual,
        historial: historial ?? this.historial,
      );
}
