import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:routes_app/bloc/location/my_location_bloc.dart';
import 'package:routes_app/bloc/map/map_bloc.dart';
import 'package:routes_app/widgets/widgets.dart';


class MapScreen extends StatefulWidget {

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  LatLng centerMap;

  @override
  void initState() {
    // iniciar seguimiento de la ubicacion del dispositivo
    context.read<MyLocationBloc>().initTracing();
    super.initState();
  }

  @override
  void dispose() {
    context.read<MyLocationBloc>().stopTracing();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MyLocationBloc, MyLocationState>(
        builder: (context, state) => this.showMap(state),
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnLocation(),
          BtnTrackRoute(),
          BtnRoute()
        ],
      ),
    );
  }

  Widget showMap(MyLocationState state) {
    if(!state.locationExist) return Center(child: Text("Locating..."));

    // Bug del linter
    // ignore: close_sinks
    final mapBloc = BlocProvider.of<MapBloc>(context);

    mapBloc.add(OnLocationUpdate(state.location));

    final cameraPosition = new CameraPosition(
      target: state.location,
      zoom: 17,
    );

    return GoogleMap(
      initialCameraPosition: cameraPosition,
      compassEnabled: true,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: mapBloc.initMap,
      polylines: mapBloc.state.polylines?.values?.toSet(),
      onCameraMove: (CameraPosition cameraPosition) {
        this.centerMap = cameraPosition.target;
      },
      onCameraIdle: () {
        mapBloc.add(OnMovedMap(centerMap));
      },
    );
  }
}