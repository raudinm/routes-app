part of 'widgets.dart';


class BtnTrackRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final mapBloc = context.watch<MapBloc>();

    return BlocBuilder<MapBloc, MapState>(
      builder: (BuildContext context, MapState state) {
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 25,
            child: IconButton(
              onPressed: () {
                mapBloc.add(OnTraceCamera());
              },
              icon: Icon(
                state.traceCamera
                  ? Icons.directions_run
                  : Icons.accessibility_new,
                color: Colors.black87,
              ),
            ),
          ),
        );
      },
    );
  }
}