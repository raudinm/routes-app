import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routes_app/bloc/location/my_location_bloc.dart';
import 'package:routes_app/bloc/map/map_bloc.dart';

import 'package:routes_app/screens/screens.dart';


void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => new MyLocationBloc()),
        BlocProvider(create: (BuildContext context) => new MapBloc()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Routes App',
          home: LoadingScreen(),
          routes: {
            'maps': (_) => MapScreen(),
            'gpsaccess': (_) => GPSAccessScreen(),
            'loading': (_) =>  LoadingScreen() ,
      },
    ));
  }
}