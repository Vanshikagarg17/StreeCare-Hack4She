import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:streecare/Components/styles.dart';
import 'package:streecare/Meetups/MeetRegistered.dart';

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  Firestore firestore = Firestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  List<bool> isSelected = [true, false];
  int gender;
  bool isSearched = false;
  bool searchBar = false;

  void toggleMenu(int ind) {
    setState(() {
      for (int i = 0; i < 2; i++) {
        if (i == ind)
          isSelected[i] = true;
        else
          isSelected[i] = false;
      }
    });
  }

  void getUser() async {
    _user = await _auth.currentUser();
    print(_user.uid);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  // data() async{
  //   var results=await Firestore.instance.collection('donor').where('places', arrayContains:"Krishna" ).getDocuments();
  //   results.documents.forEach((res) {
  //     print(res.data['name']);
  //   });
  //   print(results.documents[0].data['name']);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffe82a7),
        elevation: 0,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        title: searchBar
            ? TextField(
                decoration: kSearchFieldDecor,
                style: kInfoText.copyWith(color: Colors.white),
                cursorColor: Colors.white,
              )
            : Center(
                child: Text(
                  'MeetUps',
                  style: kGenderSelected,
                ),
              ),
        leading: GestureDetector(
          onTap: () {
            //TODO: Back Functionality
            setState(() {
              searchBar = false;
            });
            // if(isSearched)
            // {
            //   setState(() {
            //     screens[1] = BoardPage(searchedQuery: '',);
            //   });
            // }
            // else
            // {
            //
            // }
          },
          child: Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  searchBar = !searchBar;
                });
              },
              child: Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        toggleMenu(0);
                      },
                      child: Text(
                        'Registered',
                        style:
                            TextStyle(color: Color(0xff756d7f), fontSize: 18),
                      )),
                  Visibility(
                      visible: isSelected[0],
                      child: SizedBox(
                          width: 45,
                          child: Divider(
                            thickness: 2,
                            color: Color(0xf0ff5252),
                          ))),
                ],
              ),
              Column(
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        toggleMenu(1);
                      },
                      child: Text(
                        'Created',
                        style:
                            TextStyle(color: Color(0xff756d7f), fontSize: 18),
                      )),
                  Visibility(
                      visible: isSelected[1],
                      child: SizedBox(
                          width: 45,
                          child: Divider(
                            thickness: 2,
                            color: Color(0xf0ff5252),
                          )))
                ],
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Flexible(
              child: FutureBuilder(
            future: FirebaseAuth.instance.currentUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return StreamBuilder<QuerySnapshot>(
                    stream: isSelected[0]
                        ? firestore
                            .collection('MeetUps')
                            .where('attendees', arrayContains: _user.uid)
                            .snapshots()
                        : firestore
                            .collection('MeetUps')
                            .where('created', isEqualTo: _user.uid)
                            .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasData) {
                        List<Widget> usersList = [];
                        final docs = snapshot.data.documents;
                        for (var document in docs) {
                          print(document.data);
                          var title = document.data['title'];
                          var city = document.data['city'];
                          var description = document.data['description'];
                          var date = document.data['date'];
                          var landmark = document.data['landmark'];
                          var mobile = document.data['mobile'];
                          var seats = document.data['seats'];
                          var state = document.data['state'];
                          var duration = document.data['duration'];
                          var time = document.data['time'];
                          var id = document.documentID;

                          if (true) {
                            usersList.add(isSelected[0]
                                ? ExploreView(
                                    title: title,
                                    description: description,
                                    city: city,
                                    date: date,
                                    landmark: landmark,
                                    mobile: mobile,
                                    seats: seats,
                                    state: state,
                                    duration: duration,
                                    time: time,
                                    id: id,
                                    register: false,
                                    delete: false)
                                : ExploreView(
                                    title: title,
                                    description: description,
                                    city: city,
                                    date: date,
                                    landmark: landmark,
                                    mobile: mobile,
                                    seats: seats,
                                    state: state,
                                    duration: duration,
                                    time: time,
                                    id: id,
                                    register: false,
                                    delete: true));
                            //     PatientView(
                            //       name: name, age: age, bloodGroup: bloodGroup, gender: genders[gender], lastTested: lastTested,
                            //       relation: relation, hospital: hospital, contact: contact, city: city, state: state, pincode: pincode,
                            //       bp: bp, diabetes: diabetes, preMedical: preMedical, extraDetails: moreDetails, neededDate: '19/05/2020',
                            //
                            //     )
                            //);
                          }
                        }

                        if (usersList.isEmpty) {
                          return Container(
                            child: Center(
                              child: Text(
                                '🙁 No Records Found',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.grey),
                              ),
                            ),
                          );
                        }
                        return ListView(
                          children: usersList,
                        );
                      }
                      return Container();
                    });
              }
              return Container();
            },
          ))
        ],
      )),
    );
  }
}
