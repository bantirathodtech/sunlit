import 'package:animations/animations.dart';
import 'package:common/common_widgets.dart';

class CustomPageRoute extends PageRouteBuilder {
  CustomPageRoute({required this.child})
      : super(
      pageBuilder: (context, Animation<double> animation,
          Animation<double> secondaryAnimation) =>
      child,
      //transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return PageTransitionSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (
              Widget child,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              ) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: child,
        );
      }
  );
  Widget child;
}
