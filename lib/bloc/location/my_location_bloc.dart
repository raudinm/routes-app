import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:meta/meta.dart';

part 'my_location_event.dart';
part 'my_location_state.dart';


class MyLocationBloc extends Bloc<MyLocationEvent, MyLocationState> {
  MyLocationBloc() : super(MyLocationState());

  StreamSubscription<Position> _positionSubscription;

  void initTracing() {
    this._positionSubscription = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10,
    ).listen((Position event) {
      final newLocation = new LatLng(event.latitude, event.longitude);
      add(OnLocationChange(newLocation));
    });
  }

  void stopTracing() => _positionSubscription?.cancel();

  @override
  Stream<MyLocationState> mapEventToState(MyLocationEvent event) async* {
    if(event is OnLocationChange) {
      yield state.copyWith(
        locationExist: true,
        location: event.location
      );
    }
  }
}
