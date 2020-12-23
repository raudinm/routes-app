import 'package:flutter/material.dart';
import 'package:routes_app/screens/screens.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Routes App',
      home: LoadingScreen(),
      routes: {
        'maps': (_) => MapScreen(),
        'gpsaccess': (_) => GPSAccessScreen(),
        'loading': (_) =>  LoadingScreen()
      },
    );
  }
}