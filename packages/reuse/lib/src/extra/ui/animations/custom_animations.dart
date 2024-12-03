// // lib/common/animations/custom_animations.dart
//
// import 'package:flutter/material.dart';
//
// // Custom Fade Transition
// class FadeTransitionPage extends PageRouteBuilder {
//   final Widget page;
//
//   FadeTransitionPage({required this.page})
//       : super(
//     pageBuilder: (context, animation, secondaryAnimation) => page,
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = 0.0;
//       const end = 1.0;
//       const curve = Curves.easeInOut;
//       var tween = Tween(begin: begin, end: end);
//       var opacityAnimation = animation.drive(
//           tween.chain(CurveTween(curve: curve)));
//       return FadeTransition(opacity: opacityAnimation, child: child);
//     },
//   );
// }
//
// // Custom Slide Transition
// class SlideTransitionPage extends PageRouteBuilder {
//   final Widget page;
//   final AxisDirection direction;
//
//   SlideTransitionPage({
//     required this.page,
//     this.direction = AxisDirection.right,
//   }) : super(
//     pageBuilder: (context, animation, secondaryAnimation) => page,
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(1.0, 0.0); // Default direction
//       Offset end = Offset.zero;
//       Offset offset = begin;
//       switch (direction) {
//         case AxisDirection.left:
//           offset = Offset(-1.0, 0.0);
//           break;
//         case AxisDirection.right:
//           offset = Offset(1.0, 0.0);
//           break;
//         case AxisDirection.up:
//           offset = Offset(0.0, -1.0);
//           break;
//         case AxisDirection.down:
//           offset = Offset(0.0, 1.0);
//           break;
//       }
//       var tween = Tween(begin: offset, end: end);
//       var offsetAnimation = animation.drive(
//           tween.chain(CurveTween(curve: Curves.easeInOut)));
//       return SlideTransition(position: offsetAnimation, child: child);
//     },
//   );
//
// // Custom Scale Transition
//   class ScaleTransitionPage extends PageRouteBuilder {
//   final Widget page;
//
//   ScaleTransitionPage({required this.page})
//       : super(
//   pageBuilder: (context, animation, secondaryAnimation) => page,
//   transitionsBuilder: (context, animation, secondaryAnimation, child) {
//   const begin = 0.0;
//   const end = 1.0;
//   const curve = Curves.easeInOut;
//   var tween = Tween(begin: begin, end: end);
//   var scaleAnimation = animation.drive(tween.chain(CurveTween(curve: curve)));
//   return ScaleTransition(scale: scaleAnimation, child: child);
//   },
//   );
//
// // Custom Rotation Transition
//   class RotationTransitionPage extends PageRouteBuilder {
//   final Widget page;
//
//   RotationTransitionPage({required this.page})
//       : super(
//   pageBuilder: (context, animation, secondaryAnimation) => page,
//   transitionsBuilder: (context, animation, secondaryAnimation, child) {
//   const begin = 0.0;
//   const end = 1.0;
//   const curve = Curves.easeInOut;
//   var tween = Tween(begin: begin, end: end);
//   var rotationAnimation = animation.drive(tween.chain(CurveTween(curve: curve)));
//   return RotationTransition(
//   turns: rotationAnimation,
//   child: child,
//   );
//   },
//   );
//
// // Custom Curve Transition
//   class CustomCurveTransition extends StatelessWidget {
//   final Widget child;
//   final AnimationController controller;
//
//   CustomCurveTransition({
//   required this.child,
//   required this.controller,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//   final animation = CurvedAnimation(
//   parent: controller,
//   curve: Curves.fastOutSlowIn,
//   );
//
//   return FadeTransition(
//   opacity: animation,
//   child: ScaleTransition(
//   scale: animation,
//   child: child,
//   ),
//   );
//   }
//   }
//Purpose: Provides custom animations and transitions for enhancing the user experience.
// Usage: Used to create and manage animations to enhance the app's UI/UX.
