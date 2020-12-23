import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:routes_app/helpers/helpers.dart';
import 'package:routes_app/screens/screens.dart';


class LoadingScreen extends StatefulWidget {

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with  WidgetsBindingObserver {

  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    // Escuchar cambios en el ciclo de vida de la app
    if(state == AppLifecycleState.resumed) {
      // Verify Location services
      if(await Geolocator.isLocationServiceEnabled()) {
        Navigator.pushReplacement(context, navigateToMapFadeIn(context, MapScreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.checkGPSAndLocation(context),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {

          if(snapshot.hasData) {
            return Center(child: Text(snapshot.data));
          }
          return Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          );
        },
      ),
    );
  }

  Future<String> checkGPSAndLocation(BuildContext context) async {
    // Verify GPS permission
    final gpsPermission = await Permission.location.isGranted;
    // Verify Location services
    final activeGps = await Geolocator.isLocationServiceEnabled();

    if(gpsPermission && activeGps) {
      Navigator.pushReplacement(context, navigateToMapFadeIn(context, MapScreen()));
      return '';
    } else if(!gpsPermission) {
      Navigator.pushReplacement(context, navigateToMapFadeIn(context, GPSAccessScreen()));
      return "Esnecesario el permiso del GPS";
    } else {
      return "Active el GPS";
    }
  }
}