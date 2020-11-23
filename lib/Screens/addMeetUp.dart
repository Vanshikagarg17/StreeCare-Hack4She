import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddMeetUp extends StatefulWidget {
  @override
  _AddMeetUpState createState() => _AddMeetUpState();
}

class _AddMeetUpState extends State<AddMeetUp> {
  var title = TextEditingController();
  var description = TextEditingController();
  var mobile = TextEditingController();
  var seats = TextEditingController();
  var date = 'Select date';
  var time2 = 'Select Time';

  _addToFirestore() async {
    final _user = await FirebaseAuth.instance.currentUser();
    final _uid = _user.uid;
    Map<String, Object> data = <String, Object>{
      'title': title.text,
      'description': description.text,
      'mobile': mobile.text,
      'seats': seats.text,
      'date': date,
      'time': time2,
      'posted_by': _uid,
      'location': _myLocation.data
    };
    Firestore.instance.collection('MeetUps').document().setData(data);
  }
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  GeoFirePoint _myLocation;
  final geo = Geoflutterfire();
  double latitude, longitude;
  _getCurrentLocation() {
    Firestore firestore = Firestore.instance;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      latitude = position.latitude;
      longitude = position.longitude;
      GeoFirePoint myLocation =
      geo.point(latitude: latitude, longitude: longitude);
      this._myLocation = myLocation;
      setState(() {
        _myLocation=myLocation;
      });
    }).catchError((e) {
      print(e);
    });

    // FlutterToast.showToast(msg: _myLocation.latitude.toString());
  }
      @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentLocation();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Meet Up'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  height: 50,
                  child: TextField(
//                cursorColor: shading,
                    style: TextStyle(
//                    fontSize: 20, color: primaryColor1
                        ),
                    controller: title,
                    decoration: InputDecoration(
//                  focusColor: primaryColor1,
                      hintStyle: TextStyle(
                        fontSize: 20,
//                      color: shading
                      ),
                      hintText: 'Title',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
//                        color: shading
                            ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
//                        color: shading
                            ),
                      ),
                    ),
                  )),
              Container(
                  child: TextField(
//                cursorColor: shading,
                style: TextStyle(
//                    fontSize: 20, color: primaryColor1
                    ),
                maxLines: 5,
                controller: description,
                decoration: InputDecoration(
//                  focusColor: primaryColor1,
                  hintStyle: TextStyle(
                    fontSize: 20,
//                      color: shading
                  ),
                  hintText: 'Description',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
//                        color: shading
                        ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
//                        color: shading
                        ),
                  ),
                ),
              )),
              FlatButton(
                child: Text(date),
                onPressed: () {
                  final now = DateTime.now();
                  return showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(now.year, now.month, now.day)
                              .subtract(Duration(days: 30)),
                          lastDate: DateTime(now.year, now.month, now.day))
                      .then((value) {
                    setState(() {
                      date = new DateFormat.yMMMd().format(DateTime.now());
                    });
                  });
                },
              ),
              TimePickerSpinner(
                is24HourMode: false,
                normalTextStyle: TextStyle(
                  fontSize: 24,
//                  color: shading.withOpacity(0.5)
                ),
//              highlightedTextStyle:
//              TextStyle(fontSize: 24, color: primaryColor1),
                spacing: 40,
                itemHeight: 50,
                isForce2Digits: true,
                onTimeChange: (time) {
                  setState(() {
                    time2 = DateFormat('Hm').format(time);
                  });
                },
              ),
              Container(
                  height: 50,
                  child: TextField(
//                cursorColor: shading,
                    style: TextStyle(
//                    fontSize: 20, color: primaryColor1
                        ),
                    controller: mobile,
                    decoration: InputDecoration(
//                  focusColor: primaryColor1,
                      hintStyle: TextStyle(
                        fontSize: 20,
//                      color: shading
                      ),
                      hintText: 'Mobile',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
//                        color: shading
                            ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
//                        color: shading
                            ),
                      ),
                    ),
                  )),
              Container(
                  height: 50,
                  child: TextField(
//                cursorColor: shading,
                    style: TextStyle(
//                    fontSize: 20, color: primaryColor1
                        ),
                    controller: seats,
                    decoration: InputDecoration(
//                  focusColor: primaryColor1,
                      hintStyle: TextStyle(
                        fontSize: 20,
//                      color: shading
                      ),
                      hintText: 'No of seats',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
//                        color: shading
                            ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
//                        color: shading
                            ),
                      ),
                    ),
                  )),
              RaisedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    _addToFirestore();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
