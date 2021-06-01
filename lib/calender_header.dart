import 'package:calendar/events_symbol.dart';
import 'package:flutter/material.dart';

const kEventsTextFontSize = 12.0;
const kEventIndicatorRadius = 8.0;
const kSpaceBetweenIndicatorAndText = 5.0;
const kCalenderFormatButtonFontSize = 12.0;
const kActiveButtonTextColor = Colors.black;
const kInActiveButtonTextColor = Colors.grey;
const kActiveButtonBackgroundColor = Colors.white;
const kInActiveButtonBackgroundColor = Color(0xFFE8E8E8);
const kActiveButtonElevation = 8.0;
const kInActiveButtonElevation = 0.0;

class CalenderHeader extends StatefulWidget {
  @override
  _CalenderHeaderState createState() => _CalenderHeaderState();
}

class _CalenderHeaderState extends State<CalenderHeader> {

  bool _isDayButtonActive = true;
  bool _isMonthButtonActive = false;
  bool _isLifeButtonActive = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Text(
              'Today',
              style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              '- Sep 25th 2021-',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
              bottom: 16.0,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EventDefinition(
                        color: Colors.redAccent,
                        fontSize: kEventsTextFontSize,
                        radius: kEventIndicatorRadius,
                        space: kSpaceBetweenIndicatorAndText,
                        title: 'Past',
                      ),
                      EventDefinition(
                        color: Colors.green,
                        fontSize: kEventsTextFontSize,
                        radius: kEventIndicatorRadius,
                        space: kSpaceBetweenIndicatorAndText,
                        title: 'Present',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EventDefinition(
                        color: Colors.blue,
                        fontSize: kEventsTextFontSize,
                        radius: kEventIndicatorRadius,
                        space: kSpaceBetweenIndicatorAndText,
                        title: 'Future',
                      ),
                      EventDefinition(
                        color: Colors.orange,
                        fontSize: kEventsTextFontSize,
                        radius: kEventIndicatorRadius,
                        space: kSpaceBetweenIndicatorAndText,
                        title: 'Neutral',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                         _isDayButtonActive = true;
                         _isMonthButtonActive = false;
                         _isLifeButtonActive = false;
                      });
                    },
                    child: CalenderSelectorButton(
                      isButtonActive: _isDayButtonActive?true:false,
                      buttonText: 'Day(s)',
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        _isDayButtonActive = false;
                        _isMonthButtonActive = true;
                        _isLifeButtonActive = false;
                      });
                    },
                    child: CalenderSelectorButton(
                      isButtonActive: _isMonthButtonActive?true:false,
                      buttonText: 'Month',
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        _isDayButtonActive = false;
                        _isMonthButtonActive = false;
                        _isLifeButtonActive = true;
                      });
                    },
                    child: CalenderSelectorButton(
                      isButtonActive: _isLifeButtonActive ? true:false,
                      buttonText: 'Life',
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CalenderSelectorButton extends StatelessWidget {
  final bool isButtonActive;
  final String buttonText;

  CalenderSelectorButton({
    @required this.isButtonActive,
    @required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation:
          isButtonActive ? kActiveButtonElevation : kInActiveButtonElevation,
      color: isButtonActive
          ? kActiveButtonBackgroundColor
          : kInActiveButtonBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: kCalenderFormatButtonFontSize,
              fontWeight: FontWeight.bold,
              color: isButtonActive
                  ? kActiveButtonTextColor
                  : kInActiveButtonTextColor,
            ),
          ),
        ),
      ),
    );
  }
}

class EventDefinition extends StatelessWidget {
  final String title;
  final double radius;
  final Color color;
  final double fontSize;
  final double space;

  EventDefinition({
    @required this.title,
    @required this.radius,
    @required this.color,
    @required this.fontSize,
    @required this.space,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        EventSymbol(
          radius: radius,
          color: color,
        ),
        SizedBox(
          width: space,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

// class FormatButton extends StatelessWidget {
//   const FormatButton({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {},
//       child: Text(
//         'life',
//         style: TextStyle(
//           color: kInActiveButtonTextColor,
//           fontSize: kCalenderFormatButtonFontSize,
//         ),
//       ),
//       style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all(
//             kInActiveButtonBackgroundColor.shade200),
//         elevation:
//         MaterialStateProperty.all(kInActiveButtonElevation),
//         padding: MaterialStateProperty.all(
//           EdgeInsets.all(0.0),
//         ),
//         shape: MaterialStateProperty.all(
//           RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.0),
//           ),
//         ),
//       ),
//     );
//   }
// }
