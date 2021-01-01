import 'dart:async';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_event.dart';
part 'map_state.dart';


class MapBloc extends Bloc<MapEvent, MapState> {

  GoogleMapController _mapController;

  MapBloc() : super(MapState());

  void initMap(GoogleMapController controller) {
    if(!state.mapReady) {
      _mapController = controller;
      // TODO: Cambiar estilos del mapa

      add(OnMapReady());
    }
  }

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if(event is OnMapReady) {
      yield state.copyWith(mapReady: true);
    }
  }
}
