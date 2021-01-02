import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart' show Colors;
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:routes_app/theme/map_theme.dart';

part 'map_event.dart';
part 'map_state.dart';


class MapBloc extends Bloc<MapEvent, MapState> {

  GoogleMapController _mapController;

  MapBloc() : super(MapState());

  // Polylines
  Polyline _myRoute = new Polyline(
    polylineId: PolylineId('my_route'),
    color: Colors.black87,
    width: 4
  );

  void initMap(GoogleMapController controller) {
    if(!state.mapReady) {
      _mapController = controller;
      
      _mapController.setMapStyle(jsonEncode(uberMapTheme));

      add(OnMapReady());
    }
  }

  void moveCamera(LatLng position) {
    final cameraUpdate = CameraUpdate.newLatLng(position);
    _mapController?.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if(event is OnMapReady) {
      yield state.copyWith(mapReady: true);

    } else if(event is OnLocationUpdate) {
      yield* _onLocationUpdate(event);

    } else if(event is OnShowTraceRoute) {  
      yield* _onShowTraceChange(event);

    } else if(event is OnTraceCamera) {
      yield* _onTraceCameraChange(event);

    } else if(event is OnMovedMap) {
      yield state.copyWith(centralLocation: event.centerMap);
    }
  }

  Stream<MapState> _onTraceCameraChange(OnTraceCamera event) async* {

    if(!state.traceCamera) {
      this.moveCamera(this._myRoute.points[_myRoute.points.length - 1]);
    }
    yield state.copyWith(traceCamera: !state.traceCamera);
  }

  Stream<MapState> _onLocationUpdate(OnLocationUpdate event) async* {

    if(state.traceCamera) {
      this.moveCamera(event.location);
    }

    List<LatLng> points = [...this._myRoute.points, event.location];
    this._myRoute = this._myRoute.copyWith(pointsParam: points);

    final currentPolylines = state.polylines;
    currentPolylines['my_route'] = this._myRoute; 
    yield state.copyWith(polylines: currentPolylines);
  }

  Stream<MapState> _onShowTraceChange(OnShowTraceRoute event) async* {
    if(!state.traceRoute) {
      this._myRoute = this._myRoute.copyWith(colorParam: Colors.black87);
    } else {
      this._myRoute = this._myRoute.copyWith(colorParam: Colors.transparent);
    }
      
    final currentPolylines = state.polylines;
    currentPolylines['my_route'] = this._myRoute; 

    yield state.copyWith(
      traceRoute: !state.traceRoute,
      polylines: currentPolylines
    );
  }
}
