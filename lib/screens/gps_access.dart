import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


class GPSAccessScreen extends StatefulWidget {

  @override
  _GPSAccessScreenState createState() => _GPSAccessScreenState();
}

class _GPSAccessScreenState extends State<GPSAccessScreen> with WidgetsBindingObserver {
  
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
    if(state == AppLifecycleState.resumed) {
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
                final status = await Permission.location.request();
                this.gpsAccess(status);
              }
            )
          ],
        ),
      )
    );
  }

  void gpsAccess(PermissionStatus status) {

    switch (status) {
      case PermissionStatus.granted:
        Navigator.pushReplacementNamed(context, 'maps');
        break;

      case PermissionStatus.undetermined:
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
    }
  }
}