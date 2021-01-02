part of 'widgets.dart';


class BtnLocation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final locationBloc = context.watch<MyLocationBloc>();
    final mapBloc = context.watch<MapBloc>();

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          onPressed: () {
            mapBloc.moveCamera(locationBloc.state.location);
          },
          icon: Icon(Icons.my_location, color: Colors.black87,),
        ),
      ),
    );
  }
}