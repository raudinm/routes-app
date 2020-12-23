part of "helpers.dart";


Route navigateToMapFadeIn(BuildContext context, Widget screen) {
  return PageRouteBuilder(
    pageBuilder: (context, Animation<double> animation, Animation<double> secondary) {
      return screen;
    },
    transitionDuration: Duration(milliseconds: 600),
    transitionsBuilder: (context, animation, secondary, child) {
      return FadeTransition(
        child: child,
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animation,  curve: Curves.easeOut)
        ),
      );
    }
  );
}