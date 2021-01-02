part of 'widgets.dart';


class BtnRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final mapBloc = context.watch<MapBloc>();

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          onPressed: () {
            mapBloc.add(OnShowTraceRoute());
          },
          icon: Icon(
            Icons.more_horiz, 
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}