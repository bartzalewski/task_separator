import 'dart:async';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int hour = 0;
  int min = 0;
  int sec = 0;
  bool started = true;
  bool stopped = true;
  int timeForTimer = 0;
  String timeToDisplay = '';
  bool checkTimer = true;

  void start() {
    setState(() {
      started = false;
      stopped = false;
    });
    timeForTimer = ((hour * 60 * 60) + (min * 60) + sec);
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timeForTimer < 1 || checkTimer == false) {
          t.cancel();
          if (timeForTimer == 0) {
            debugPrint('Stopped by default');
          }
          checkTimer = true;
          timeToDisplay = "";
          started = true;
          stopped = true;
          // notification here
        } else if (timeForTimer < 60) {
          timeToDisplay = timeForTimer.toString();
          timeForTimer = timeForTimer - 1;
        } else if (timeForTimer < 3600) {
          int m = timeForTimer ~/ 60;
          int s = timeForTimer - (60 * m);
          timeToDisplay = m.toString() + ":" + s.toString();
          timeForTimer = timeForTimer - 1;
        } else {
          int h = timeForTimer ~/ 3600;
          int t = timeForTimer - (3600 * h);
          int m = t ~/ 60;
          int s = t ~/ (60 * m);
          timeToDisplay =
              h.toString() + ":" + m.toString() + ":" + s.toString();
          timeForTimer = timeForTimer - 1;
        }
      });
    });
  }

  void stop() {
    setState(() {
      started = true;
      stopped = true;
      checkTimer = false;
    });
  }

  Widget timer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              flex: 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            'HH',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins'),
                          )),
                      NumberPicker.integer(
                        initialValue: hour,
                        minValue: 0,
                        maxValue: 23,
                        listViewWidth: 60.0,
                        onChanged: (val) {
                          setState(() {
                            hour = val;
                          });
                        },
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            'MM',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins'),
                          )),
                      NumberPicker.integer(
                        initialValue: min,
                        minValue: 0,
                        maxValue: 60,
                        listViewWidth: 60.0,
                        onChanged: (val) {
                          setState(() {
                            min = val;
                          });
                        },
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            'SS',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins'),
                          )),
                      NumberPicker.integer(
                        initialValue: sec,
                        minValue: 0,
                        maxValue: 60,
                        listViewWidth: 60.0,
                        onChanged: (val) {
                          setState(() {
                            sec = val;
                          });
                        },
                      )
                    ],
                  )
                ],
              )),
          Card(
            child: ListTile(
              onTap: () {},
              title: Text(
                'Learn React',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              leading: CircleAvatar(
                child: Text(
                  '1',
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {},
              title: Text(
                'Code Schoolify',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              leading: CircleAvatar(
                child: Text(
                  '2',
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {},
              title: Text(
                'Learn Flutter',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              leading: CircleAvatar(
                child: Text(
                  '3',
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              timeToDisplay,
              style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: started ? start : null,
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  color: Colors.green,
                  child: Text(
                    'Start',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                RaisedButton(
                  onPressed: stopped ? null : stop,
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  color: Colors.red,
                  child: Text(
                    'Stop',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Task Separator',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          elevation: 0.0,
          centerTitle: true,
        ),
        body: Container(child: timer()));
  }
}
