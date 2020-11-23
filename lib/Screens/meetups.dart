import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:streecare/Screens/addMeetUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:translator/translator.dart';

class Meetups extends StatefulWidget {
  @override
  _MeetupsState createState() => _MeetupsState();
}

class _MeetupsState extends State<Meetups> {
  List<String> titles = [];
  List<String> date = [];
  List<String> time = [];
  List<String> seats = [];
  List<String> mobile = [];
  List<String> description = [];
  List<String> documentID = [];
  dynamic listview1 = Container();

  Future _getData() async {
    final _user = await FirebaseAuth.instance.currentUser();
    final _uid = _user.uid;
    final snapShot1 =
        await Firestore.instance.collection('MeetUps').getDocuments();
    snapShot1.documents.forEach((element) {
      setState(() {
        titles.add(element.data['title']);
        date.add(element.data['date']);
        time.add(element.data['time']);
        mobile.add(element.data['mobile']);
        seats.add(element.data['seats']);
        description.add(element.data['description']);
        documentID.add(element.documentID);
      });
    });
  }

  dynamic text = "";

  _translate(String data) async {
    final translator = GoogleTranslator();
    var translation = await translator.translate(data, to: 'hi');
    return translation.text;
  }

  @override
  void initState() {
    super.initState();
    _getData().then((value) => _set());
  }

  _set() {
    setState(() {
      listview1 = _cards(titles, date, time, seats);
    });
  }

  Widget _cards(titles, date, time, seats) {
    return ListView.builder(
        //scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return Card(
            child: GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        titles[index],
                        style: TextStyle(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(date[index]),
                          Text(time[index]),
                          Text(seats[index])
                        ],
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterForMeetup(
                              titles[index],
                              date[index],
                              time[index],
                              description[index],
                              seats[index],
                              documentID[index])));
                }),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listview1,
      floatingActionButton: FloatingActionButton(
        child: Icon(CupertinoIcons.plus),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddMeetUp()));
        },
      ),
    );
  }
}

class RegisterForMeetup extends StatefulWidget {
  var titles;
  var date;
  var time;
  var description;
  var seats;
  var documentID;
  RegisterForMeetup(this.titles, this.date, this.time, this.description,
      this.seats, this.documentID);
  @override
  _RegisterForMeetupState createState() => _RegisterForMeetupState(
      titles, date, time, description, seats, documentID);
}

class _RegisterForMeetupState extends State<RegisterForMeetup> {
  var titles;
  var date;
  var time;
  var description;
  var seats;
  var documentID;
  _RegisterForMeetupState(this.titles, this.date, this.time, this.description,
      this.seats, this.documentID);

  _register() async {
    final _user = await FirebaseAuth.instance.currentUser();
    final _uid = _user.uid;
    Firestore.instance.collection('MeetUps').document(documentID).updateData({
      'attendees': FieldValue.arrayUnion([_uid])
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(titles),
          Text(date),
          Text(time),
          Text(description),
          Text(seats),
          RaisedButton(
              child: Text('Register'),
              onPressed: () {
                _register();
              })
        ],
      ),
    );
  }
}
