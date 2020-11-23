import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import 'package:streecare/Components/styles.dart';
import 'package:streecare/Meetups/MeetUpExplore.dart';



class CreateMeetUp extends StatefulWidget {
  @override
  _CreateMeetUpState createState() => _CreateMeetUpState();
}

class _CreateMeetUpState extends State<CreateMeetUp> {


 DateFormat formatter = DateFormat.yMd();
  DateTime now = DateTime.now();


  double isSpinning = 0;

  //Form Variables
 DateTime testDate = DateTime.now();
  var uid;
  var title = TextEditingController();
  var description = TextEditingController();
 var state = TextEditingController();
 var city = TextEditingController();
 var landmark=TextEditingController();
  var mobile ;
  var seats = TextEditingController();
  var duration=TextEditingController();
  var date = 'Select date';
  var time2 = 'Select Time';
  bool isNumber=false;


 _addToFirestore() async {
   final _user = await FirebaseAuth.instance.currentUser();
   final _uid = _user.uid;
   Map<String, Object> data = <String, Object>{
     'title': title.text,
     'description': description.text,
     'mobile': mobile,
     'seats': seats.text,
     'date': date,
     'time': time2,
     'posted_by': _uid,
     'location': _myLocation.data,
     'state':state.text,
     'city':city.text,
     'landmark':landmark.text,
     'timstamp':DateTime.now(),
     'attendees': FieldValue.arrayUnion([]),
     'created': _uid

   };
   Firestore.instance.collection('MeetUps').document().setData(data).then((value) => {


   });
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
  Future<void> _selectDate(BuildContext context) async{
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: testDate,
      firstDate: now,
      lastDate: DateTime(2021,11),
    );
    if(picked != null && picked!=testDate)
    {
      setState(() {
        testDate = picked;
      });
    }
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
        resizeToAvoidBottomPadding: true,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(0xfffe82a7),
          ),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Create a Meetup',style: kMainTitle,),
                    //Icon(Icons.favorite,color: Color(0xffc62828),)
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.04,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02),
                    width: MediaQuery.of(context).size.width*0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Column(
                      children: <Widget>[

                        Expanded(
                          child: SingleChildScrollView(
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 30,),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05,vertical: 15),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.19,
                                        child: Text(
                                          'Title',
                                          style: kLabelStyle,

                                        ),
                                      ),
                                      SizedBox(width: 15,),
                                      Flexible(
                                        child: TextField(
                                          controller: title,
                                          textAlign: TextAlign.center,
                                          decoration: kTextFieldDecor.copyWith(
                                              hintText: "Enter the title"
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05,vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Container(
                                          child: Text('Date ',style: kLabelStyle,),
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.45,
                                            height: 45,
                                            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                            decoration: BoxDecoration(
                                              color: Color(0xffef9a9a),
                                              borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
                                            ),
                                            child: Center(child: Text(formatter.format(testDate),style: kDateStyle,)),
                                          ),
                                          InkWell(
                                            onTap: ()=> _selectDate(context),
                                            child: Container(
                                              height: 45,
                                              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                              decoration: BoxDecoration(
                                                color: Color(0xffffcdd2),
                                                borderRadius: BorderRadius.horizontal(right: Radius.circular(10)),
                                              ),
                                              child: Icon(
                                                FontAwesomeIcons.calendarAlt,
                                                color: Colors.black,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05,vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Container(
                                          child: Text('Time',style: kLabelStyle,),
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          TimePickerSpinner(
                                            is24HourMode: false,
                                            normalTextStyle: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black
                                            ),
                                            highlightedTextStyle: TextStyle(fontSize: 16,
                                                color: Color(0xffffcdd2)),

                                            spacing: 40,
                                            itemHeight: 25,
                                            isForce2Digits: true,
                                            onTimeChange: (time) {
                                              setState(() {
                                                time2 = DateFormat('Hm').format(time);
                                              });
                                            },
                                          ),

                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05,vertical: 15),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.19,
                                        child: Text(
                                          'Duration',
                                          style: kLabelStyle,
                                        ),
                                      ),
                                      SizedBox(width: 15,),
                                      Flexible(
                                        child: TextField(

                                          controller: duration,
                                          textAlign: TextAlign.center,

                                          decoration: kTextFieldDecor.copyWith(
                                            hintText: '3 hours',
                                            counterText: '',
                                            //errorText: isNumber?null:'Nearby landmark'
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05,vertical: 15),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.19,
                                        child: Text(
                                          'Contact Number',
                                          style: kLabelStyle,
                                        ),
                                      ),
                                      SizedBox(width: 15,),
                                      Flexible(
                                        child: TextField(
                                          maxLength: 10,
                                          onChanged: (value){
                                            mobile = value;
                                            if(value.length==10)
                                            {
                                              setState(() {
                                                isNumber = true;
                                              });
                                            }
                                            if(value.length<10)
                                            {
                                              setState(() {
                                                isNumber = false;
                                                print('hello');
                                              });
                                            }
                                          },
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.phone,
                                          decoration: kTextFieldDecor.copyWith(
                                              hintText: '91XXXXXXXX',
                                              counterText: '',
                                              errorText: isNumber?null:'Please enter a 10 Digit Number'
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05,vertical: 15),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.19,
                                        child: Text(
                                          'No of Seats',
                                          style: kLabelStyle,
                                        ),
                                      ),
                                      SizedBox(width: 15,),
                                      Flexible(
                                        child: TextField(

                                          controller: seats,

                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.phone,
                                          decoration: kTextFieldDecor.copyWith(
                                              hintText: '20',
                                              counterText: '',
                                              errorText: isNumber?null:'Please enter no of seats'
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05,vertical: 15),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.19,
                                        child: Text(
                                          'Landmark',
                                          style: kLabelStyle,
                                        ),
                                      ),
                                      SizedBox(width: 15,),
                                      Flexible(
                                        child: TextField(

                                          controller: landmark,
                                          textAlign: TextAlign.center,

                                          decoration: kTextFieldDecor.copyWith(
                                              hintText: 'Near hdfc bank , gandhi street',
                                              counterText: '',
                                              //errorText: isNumber?null:'Nearby landmark'
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                // Container(
                                //   margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05,vertical: 15),
                                //   child: Row(
                                //     children: <Widget>[
                                //       Container(
                                //         width: MediaQuery.of(context).size.width*0.19,
                                //         child: Text(
                                //           'Pincode',
                                //           style: kLabelStyle,
                                //         ),
                                //       ),
                                //       SizedBox(width: 15,),
                                //       Flexible(
                                //         child: TextField(
                                //           onChanged: (value){
                                //             pinCode = value.trim();
                                //             if(value.length == 6)
                                //             {
                                //               setState(() {
                                //                 isPincode = true;
                                //               });
                                //               //myJson.getData(pinCode);
                                //             }
                                //             else{
                                //               setState(() {
                                //                 isPincode = false;
                                //               });
                                //             }
                                //           },
                                //           textAlign: TextAlign.center,
                                //           maxLength: 6,
                                //           keyboardType: TextInputType.phone,
                                //           decoration: kTextFieldDecor.copyWith(
                                //               hintText: 'Ex: 530017',
                                //               counterText: '',
                                //               errorText: isPincode?null:'Please enter a valid Pincode'
                                //           ),
                                //         ),
                                //       )
                                //     ],
                                //   ),
                                // ),

                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05,vertical: 15),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.19,
                                        child: Text(
                                          'City',
                                          style: kLabelStyle,
                                        ),
                                      ),
                                      SizedBox(width: 15,),
                                      Flexible(
                                        child: TextField(
                                          controller: city,
                                          textAlign: TextAlign.center,
                                          decoration: kTextFieldDecor.copyWith(
                                              hintText: 'Ex: Visakhapatnam'
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05,vertical: 15),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.19,
                                        child: Text(
                                          'State',
                                          style: kLabelStyle,
                                        ),
                                      ),
                                      SizedBox(width: 15,),
                                      Flexible(
                                        child: TextField(
                                          controller: state,
                                          textAlign: TextAlign.center,
                                          decoration: kTextFieldDecor.copyWith(
                                              hintText: 'Ex: Andhra Pradesh'
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),



                                SizedBox(
                                  height: MediaQuery.of(context).size.height*0.05,
                                ),

                                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05,vertical: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'More about the meetup',
                                        style: kLabelStyle,
                                      ),
                                      SizedBox(height: 15,),
                                      TextField(
                                        controller: description,
                                        textAlign: TextAlign.center,
                                        maxLines: 5,
                                        decoration: kTextFieldDecor.copyWith(
                                            hintText: 'In this workshop you will learn how to use internet for farming'
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height*0.03,),



                                SizedBox(height: MediaQuery.of(context).size.height*0.03,),


                                Center(
                                  child: GestureDetector(
                                    onTap: ()async {
                                      setState(() {
                                        isSpinning=30;
                                      });

                                      await _addToFirestore();
                                      setState(() {
                                        isSpinning=0;
                                      });


                                    },
                                    child: Card(
                                      elevation: 15,
                                      color: Color(0xfffe82a7),
                                      child: Padding(
                                        padding: EdgeInsets.all(13),
                                        child: Text(
                                          'Create',
                                          style: kGenderSelected.copyWith(
                                              fontSize: 20
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Center(
                                    child: SpinKitThreeBounce(
                                      color: Color(0xfffe82a7),
                                      size: isSpinning,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height*0.1,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
