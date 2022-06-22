import 'package:flutter/material.dart';

class NeverGlowScrollBehavior extends ScrollBehavior {
  const NeverGlowScrollBehavior();

  @override
  Widget buildViewportChrome(
          BuildContext context, Widget child, AxisDirection axisDirection) =>
      child;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const ClampingScrollPhysics();
}

class NeverGlowScrollConfiguration extends StatelessWidget {
  final Widget child;

  const NeverGlowScrollConfiguration({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const NeverGlowScrollBehavior(),
      child: child,
    );
  }
}
