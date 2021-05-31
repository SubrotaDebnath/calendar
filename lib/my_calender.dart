import 'package:calendar/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'calendar.dart';
import 'month_body.dart';

enum CalendarViews { dates, months, year }

class MyCalender extends StatefulWidget {

  @override
  _MyCalenderState createState() => _MyCalenderState();
}

class _MyCalenderState extends State<MyCalender> {

  DateTime _currentDateTime;
  DateTime _selectedDateTime;
  List<Calendar> _sequentialDates;
  int midYear;

  var previous = <Map>[];
  int month;
  int year;
  var previousMax = 2019;
  var currentYear;
  var currentMonth;
  var nextMax = 2023;
  var next = <Map>[];
  var viewYear;
  var viewMonth;
  var _calendarMonthName;

  void selectedDateTime(val){
    setState(() {
      //_selectedDateTime = val;
    });

  }

  // //var _firstDateCardKey = GlobalKey<RefreshIndicatorState>();
  //GlobalKey  _firstDateCardKey = GlobalKey();
  //
  // var dateBoxSize;
  var dateBoxPosition;

  //
  // // getSizeAndPosition(){
  // //   RenderBox _firstDateBox = _firstDateCardKey.currentContext.findRenderObject();
  // //   dateBoxSize = _firstDateBox.size;
  // //   dateBoxPosition = _firstDateBox.localToGlobal(Offset.zero);
  // //   print(dateBoxSize);
  // //   print(dateBoxPosition);
  // // }

  //var _currentDateTime = DateTime.now();

  //final GlobalKey _calenderBoxSizeKey = GlobalKey();



  @override
  void initState() {
    super.initState();
    final date = DateTime.now();
    //_currentDateTime = DateTime.now();
    _previousDateRange();
    _nextDateRange();
    _currentDateTime = DateTime(date.year, date.month);
    _selectedDateTime = DateTime(date.year, date.month, date.day);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //setState(() => _getCalendar(currentYear, currentMonth));
    });
    //WidgetsBinding.instance.addPostFrameCallback((_) => dateBoxPosition);
  }

  //void scheduleRebuild() => setState(() {});

  void _nextDateRange() {
    _currentDateTime = DateTime.now();
    while (_currentDateTime.year <= nextMax) {
      if (_currentDateTime.month == 13) {
        year = _currentDateTime.year + 1;
        month = 1;
        _currentDateTime = DateTime(_currentDateTime.year + 1, 1);
      } else {
        year = _currentDateTime.year;
        month = _currentDateTime.month;
        _currentDateTime =
            DateTime(_currentDateTime.year, _currentDateTime.month + 1);
      }
      //print('month: $month in year: $year');
      next.add({
        'month': month,
        'year': year,
      });
    }
  }

  void _previousDateRange() {
    _currentDateTime = DateTime.now();
    _currentDateTime =
        DateTime(_currentDateTime.year, _currentDateTime.month - 1);
    while (_currentDateTime.year >= previousMax) {
      if (_currentDateTime.month == 0) {
        year = _currentDateTime.year - 1;
        month = 12;
        _currentDateTime = DateTime(_currentDateTime.year - 1, 12);
      } else {
        year = _currentDateTime.year;
        month = _currentDateTime.month;
        _currentDateTime =
            DateTime(_currentDateTime.year, _currentDateTime.month - 1);
      }
      previous.add({
        'month': month,
        'year': year,
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Container(
           // margin: EdgeInsets.all(16),
           // padding: EdgeInsets.all(16),
           //height: MediaQuery.of(context).size.height,

           decoration: BoxDecoration(
             color: Colors.white,
             //borderRadius: BorderRadius.circular(20),
           ),
           child: _datesView(),
         ),
    );

  }

  // dates view
  Widget _datesView() {
    const Key centerKey = ValueKey<String>('centerWidgets');
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: 7,
          physics: NeverScrollableScrollPhysics(),
          dragStartBehavior: DragStartBehavior.start,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 0.0,
            crossAxisCount: 7,
            crossAxisSpacing: 0,
            childAspectRatio: 2,
            mainAxisExtent: 16,
          ),
          itemBuilder: (context, index) {
            return _weekDayTitle(index);
          },
        ),

        Divider(
          color: Colors.grey.shade400,
          height: 2.0,
          thickness: 1.5,
        ),
        // SizedBox(
        //   height: 20,
        // ),

        Expanded(
          child: CustomScrollView(
            center: centerKey,
            //shrinkWrap: true,
            scrollDirection: Axis.vertical,
            primary: true,
            physics: ScrollPhysics(),
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    //print('Top Index: $index');
                    //print('month: ${previous[index]['month']} in year: month: ${previous[index]['year']}');

                    _getCalendar(
                        previous[index]['year'], (previous[index]['month']));

                    DateTime now = DateTime(
                        previous[index]['year'], (previous[index]['month']));
                    var formatter = DateFormat("MMM yyyy");
                    _calendarMonthName = formatter.format(now).toString();

                    return MonthBody(_sequentialDates, _calendarMonthName, selectedDateTime);
                  },
                  childCount: previous.length,
                ),
              ),
              SliverList(
                key: centerKey,
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    ////print('Bottom Index: $index');
                    // print('month: ${next[index]['month']} in year: month: ${next[index]['year']}');

                    _getCalendar(next[index]['year'], (next[index]['month']));

                    DateTime now =
                    DateTime(next[index]['year'], (next[index]['month']));
                    var formatter = DateFormat("MMM yyyy");
                    _calendarMonthName = formatter.format(now);

                    return MonthBody(_sequentialDates, _calendarMonthName, selectedDateTime);
                  },
                  childCount: next.length,
                ),
              ),
            ],
            //scrollDirection: Axis.vertical,
          ),
        ),

        Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                '${Utility.kMonthNames[_currentDateTime.month - 1]} ${_currentDateTime.year}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ),
          ),
        )

        //Flexible(child: _calendarBody()),
      ],
    );
  }

  // calendar header
  Widget _weekDayTitle(int index) {
    return Center(
      child: Text(
        Utility.kWeekDays[index],
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // get calendar for current month
  void _getCalendar(int _year, int _month) {
    _sequentialDates = CustomCalendar().getMonthCalendar(_month, _year);
  }

}
