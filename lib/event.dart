import 'package:flutter/material.dart';

class Event extends StatelessWidget {
  final String evenType;

  Event(
      this.evenType,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.all(Radius.circular(5),),
        shape: BoxShape.circle,
        color: evenType == 'neutral'
            ? Colors.orange
            : evenType == 'past'
            ? Colors.red
            : evenType == 'present'
            ? Colors.green
            : evenType == 'future'
            ? Colors.blue
            : Colors.white,
      ),
    );
  }
}