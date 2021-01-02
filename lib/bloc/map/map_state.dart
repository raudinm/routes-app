part of 'map_bloc.dart';

@immutable
class MapState {
  final bool mapReady;
  final bool traceRoute;
  final bool traceCamera;
  final LatLng centralLocation;

  // Polylines
  final Map<String, Polyline> polylines;

  MapState({
    this.mapReady = false,
    this.traceRoute = true,
    this.traceCamera = true,
    this.centralLocation,
    Map<String,Polyline> polylines
  }): this.polylines = polylines ?? new Map();

  MapState copyWith({
    bool mapReady,
    bool traceRoute,
    bool traceCamera,
    LatLng centralLocation,
    Map<String,Polyline> polylines
  }) => MapState(
    mapReady: mapReady ?? this.mapReady,
    traceRoute: traceRoute ?? this.traceRoute,
    polylines: polylines ?? this.polylines,
    traceCamera: traceCamera ?? this.traceCamera,
    centralLocation: centralLocation ?? this.centralLocation
  );
}
