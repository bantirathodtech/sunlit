import 'package:flutter/material.dart';

/// Manages layout and responsiveness for different screen sizes and orientations.
class ResponsiveLayout {
  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 800 &&
        MediaQuery.of(context).size.width < 1200;
  }

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  }

  static Widget getResponsiveLayout({
    required BuildContext context,
    required Widget smallScreenLayout,
    required Widget mediumScreenLayout,
    required Widget largeScreenLayout,
  }) {
    if (isLargeScreen(context)) {
      return largeScreenLayout;
    } else if (isMediumScreen(context)) {
      return mediumScreenLayout;
    } else {
      return smallScreenLayout;
    }
  }

  static EdgeInsets getResponsivePadding(BuildContext context) {
    if (isLargeScreen(context)) {
      return EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0);
    } else if (isMediumScreen(context)) {
      return EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0);
    } else {
      return EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0);
    }
  }

  static EdgeInsets getResponsiveMargin(BuildContext context) {
    if (isLargeScreen(context)) {
      return EdgeInsets.all(20.0);
    } else if (isMediumScreen(context)) {
      return EdgeInsets.all(10.0);
    } else {
      return EdgeInsets.all(5.0);
    }
  }

  static double getResponsiveFontSize(
      BuildContext context, double small, double medium, double large) {
    if (isLargeScreen(context)) {
      return large;
    } else if (isMediumScreen(context)) {
      return medium;
    } else {
      return small;
    }
  }
}
//Purpose: Manages layout and responsiveness for different screen sizes and orientations.
// Usage: Used to ensure the app layout is responsive across different devices.
