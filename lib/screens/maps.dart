import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routes_app/bloc/location/my_location_bloc.dart';


class MapScreen extends StatefulWidget {

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

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
      )
    );
  }

  Widget showMap(MyLocationState state) {
    if(!state.locationExist) return Center(child: Text("Locating..."));

    return Text("${state.location.latitude}, ${state.location.longitude}");
  }
}