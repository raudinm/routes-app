import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


class GPSAccessScreen extends StatefulWidget {

  @override
  _GPSAccessScreenState createState() => _GPSAccessScreenState();
}

class _GPSAccessScreenState extends State<GPSAccessScreen> with WidgetsBindingObserver {
  
  bool popup = false; // For unstable context warning on iOS

  @override
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
    if(state == AppLifecycleState.resumed && !popup) {
      if(await Permission.location.isGranted) {
        Navigator.pushReplacementNamed(context, 'loading');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Es necesario el GPS para usar esta app'),
            MaterialButton(
              child: Text("Solicitar acceso", style: TextStyle(color: Colors.white)),
              color: Colors.black,
              shape: StadiumBorder(),
              splashColor: Colors.transparent,
              elevation: 0,
              onPressed: () async {
                popup = true;
                final status = await Permission.location.request();
                await this.gpsAccess(status);
                popup = false;
              }
            )
          ],
        ),
      )
    );
  }

  Future<void> gpsAccess(PermissionStatus status) async {

    switch (status) {
      case PermissionStatus.granted:
        await Navigator.pushReplacementNamed(context, 'loading');
        break;

      case PermissionStatus.undetermined:
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
    }
  }
}