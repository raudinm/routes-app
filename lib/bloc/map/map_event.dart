part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}


class OnMapReady extends MapEvent {}

class OnShowTraceRoute extends MapEvent {}

class OnTraceCamera extends MapEvent {}

class OnMovedMap extends MapEvent {
  final LatLng centerMap;

  OnMovedMap(this.centerMap);
}

class OnLocationUpdate extends MapEvent {
  final LatLng location;
  OnLocationUpdate(this.location);
}