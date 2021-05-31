import 'package:calendar/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'calendar.dart';
import 'event.dart';

class MonthBody extends StatefulWidget {
  MonthBody(
    this._sequentialDates,
    this.calendarMonthName,
    this.selectedDateTime,
  );

  final List<Calendar> _sequentialDates;
  final String calendarMonthName;
  final Function selectedDateTime;

  @override
  _MonthBodyState createState() => _MonthBodyState();
}

String _getEventTypes({@required year, @required month, @required day}) {
  String type = '';
  try {
    type = Utility.events[year.toString()][month.toString()][day.toString()];
  } catch (e) {
   // print('Event Type Exception: ${e.toString()}');
  }
  return type;
}

int midYear;
DateTime _selectedDateTime;

class _MonthBodyState extends State<MonthBody> {
  GlobalKey _gk = GlobalKey();
  Size dateBoxSize;
  Offset dateBoxPosition = Offset(0.0, 0.0);
  var dateTime;

  getSizeAndPosition() {
    setState(() {
      RenderBox _firstDateBox = _gk.currentContext.findRenderObject();
      dateBoxSize = _firstDateBox.size;
      dateBoxPosition = _firstDateBox.localToGlobal(Offset.zero);
      //print(dateBoxSize);
      //print(dateBoxPosition.dx);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getSizeAndPosition());
  }

  @override
  Widget build(BuildContext context) {
    return _calendarBody();
  }

  // calendar
  Widget _calendarBody() {
    List<Calendar> _sequentialDates = widget._sequentialDates;
    //print('Month Name: ${widget.calendarMonthName}');
    if (_sequentialDates == null) {
      return Container();
    }
    return Stack(fit: StackFit.loose, children: [
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 24.0,
          ),
          Container(
            width: double.infinity,
            // height: MediaQuery.of(context).size.height * .5,
            margin: EdgeInsets.all(8.0),
            //height: 450.0,
            //height: MainAxisSize.min,
            child: GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: _sequentialDates.length,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                crossAxisCount: 7,
                crossAxisSpacing: 0,
                //childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 2),
              ),
              itemBuilder: (context, index) {
                //if (_sequentialDates[index].date == _selectedDateTime)
                //return _selector(_sequentialDates[index]);
                //return _calendarDates(_sequentialDates[index]);

                //if (_sequentialDates[index].date != null) {

                if (_sequentialDates[index].date != null) {
                  if (_sequentialDates[index].date == _selectedDateTime)
                    return _selector(_sequentialDates[index]);
                  return _calendarDates(_sequentialDates[index]);
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
      Positioned(
        left: dateBoxPosition.dx > 330
            ? dateBoxSize.width * 5 + 20
            : dateBoxPosition.dx,
        child: Text(
          '${widget.calendarMonthName}',
          // widget.monthName,
          style: TextStyle(
            fontSize: 24.0,
            color: Colors.orange.shade800,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.start,
        ),
      ),
    ]);
  }

  Widget _calendarDates(Calendar calendarDate) {
    //Calendar calendarDate = _sequentialDates[index];
    var now = DateTime.now();

    return Container(
      key: calendarDate.date.day == 1 ? _gk : GlobalKey(),
      decoration: BoxDecoration(
        color: calendarDate.date.year == now.year &&
                calendarDate.date.month == now.month &&
                calendarDate.date.day == now.day
            ? Colors.blueGrey.shade300
            : Colors.white,
        border: Border(
          top: BorderSide(
            width: 2.0,
            color: Colors.grey.shade300,
          ),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                if (_selectedDateTime != calendarDate.date) {
                  widget.selectedDateTime(calendarDate.date);
                  setState(() => _selectedDateTime = calendarDate.date);
                }
              },
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${calendarDate.date.day}',
                        style: TextStyle(
                          color: (calendarDate.thisMonth)
                              ? (calendarDate.date.weekday == DateTime.sunday)
                                  ? Colors.black.withOpacity(.8)
                                  : Colors.black.withOpacity(.8)
                              : (calendarDate.date.weekday == DateTime.sunday)
                                  ? Colors.blueAccent.withOpacity(1)
                                  : Colors.blueAccent.withOpacity(1),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Event(
                      _getEventTypes(
                          year: calendarDate.date.year,
                          month: calendarDate.date.month,
                          day: calendarDate.date.day),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

//date selector
  Widget _selector(Calendar calendarDate) {
    //var _isVisible = calendarDate.thisMonth ? true: false;\
   // print('Selected Date ${calendarDate.date}');
    var selected = calendarDate.date.day != null ? calendarDate.date.day : '';
    return Stack(
      fit: StackFit.loose,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
              top: BorderSide(
                width: 2.0,
                color: Colors.grey.shade300,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            color: Colors.transparent,
            //margin: EdgeInsets.all(5),
            child: Container(
                  height: 30.0,
                  width: 30.0,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: Center(
                    child: Text(
                      //'${calendarDate.date.day != null ? calendarDate.date.day : ''}',
                      selected.toString(),

                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w900),
                    ),
                  ),


            ),
          ),
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: Event(
            _getEventTypes(
                year: calendarDate.date.year,
                month: calendarDate.date.month,
                day: calendarDate.date.day),
          ),
        ),
      ],
    );
  }
}
