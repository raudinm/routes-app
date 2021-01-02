part of 'map_bloc.dart';

@immutable
class MapState {
  final bool mapReady;
  final bool traceRoute;
  final bool traceCamera;

  // Polylines
  final Map<String, Polyline> polylines;

  MapState({
    this.mapReady = false,
    this.traceRoute = true,
    this.traceCamera = true,
    Map<String,Polyline> polylines
  }): this.polylines = polylines;

  MapState copyWith({
    bool mapReady,
    bool traceRoute,
    bool traceCamera,
    Map<String,Polyline> polylines
  }) => MapState(
    mapReady: mapReady ?? this.mapReady,
    traceRoute: traceRoute ?? this.traceRoute,
    polylines: polylines ?? this.polylines,
    traceCamera: traceCamera ?? this.traceCamera
  );
}
