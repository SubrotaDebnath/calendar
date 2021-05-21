import 'package:calendar/calender.dart';
import 'package:calendar/calender_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepOrange,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _settingModalBottomSheet(context);
          },
          child: Icon(Icons.calendar_today),
        ),
      ),
    );
  }
}


void _settingModalBottomSheet(context) {
  const double kSheetCornerRadius = 40.0;
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top * 3,
              // color: Colors.transparent,
            ),
            Container(
              height: 8.0,
              width: 50.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(kSheetCornerRadius),
                    topLeft: Radius.circular(kSheetCornerRadius),
                  ),
                ),
                child: Column(
                  children: [
                    CalenderHeader(),
                    Calender(),
                  ],
                ),
              ),
            ),
          ],
        );
      });
}
