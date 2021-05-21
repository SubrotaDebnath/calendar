import 'package:date_range_form_field/date_range_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class Calender extends StatefulWidget {

  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  @override
  Widget build(BuildContext context) {

    return SfCalendar(
      view: CalendarView.month,
      cellBorderColor: Colors.transparent,

    );


    // return TableCalendar(
    //    headerVisible: false,
    //    focusedDay: DateTime.now(),
    //    firstDay: DateTime(1970),
    //    lastDay: DateTime(2050),
    //
    // );
  }
}
