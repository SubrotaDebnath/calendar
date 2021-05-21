
import 'package:flutter/material.dart';

class EventSymbol extends StatelessWidget {
  final double radius;
  final Color color;

  EventSymbol({
    @required this.radius,
    @required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius,
      width: radius,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
