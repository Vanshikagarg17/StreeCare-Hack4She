import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'my_flutter_app_icons.dart' as customIcons;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:streecare/Components/my_flutter_app_icons.dart';
import 'package:streecare/Meetups/CreateMeetup.dart';
import 'package:streecare/Meetups/MeetUpBoard.dart';
import 'package:streecare/Meetups/MeetUpExplore.dart';

import 'package:streecare/Screens/addMeetUp.dart';
import 'package:streecare/Screens/meetups.dart';

class MeetUpsHomePage extends StatefulWidget {
  @override
  _MeetUpsHomePageState createState() => _MeetUpsHomePageState();
}

class _MeetUpsHomePageState extends State<MeetUpsHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xfffe82a7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'EVENT SECTION',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            Center(
              child: Text(
                'What are your next steps and goals?\nSchedule & Explore the events near you!',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 1.5,
                        width: MediaQuery.of(context).size.width / 1.25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(0xffffde59),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
//                            margin: EdgeInsets.fromLTRB(10, 10, 10, 40),
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      title: Text('Schedule',
                                          style: TextStyle(
                                              color: Color(0xff75c7fb))),
                                      trailing: GestureDetector(
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xff75c7fb),
                                                shape: BoxShape.circle),
                                            child: Icon(Icons.arrow_forward)),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CreateMeetUp()));
                                        },
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
//                            margin: EdgeInsets.fromLTRB(10, 10, 10, 40),
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      title: Text(
                                        'Explore',
                                        style:
                                            TextStyle(color: Color(0xff75c7fb)),
                                      ),
                                      trailing: GestureDetector(
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xff75c7fb),
                                                shape: BoxShape.circle),
                                            child: Icon(Icons.arrow_forward)),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Explore()));
                                        },
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Stack(children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
//                            margin: EdgeInsets.fromLTRB(10, 10, 10, 40),
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                          title: Text('Manage Meet Ups',
                                              style: TextStyle(
                                                  color: Color(0xff75c7fb))),
                                          trailing: GestureDetector(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xff75c7fb),
                                                  shape: BoxShape.circle),
                                              child: Icon(Icons.arrow_forward),
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Board()),
                                            );
                                          }),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Image(
                              height: MediaQuery.of(context).size.height / 2,
                              width: MediaQuery.of(context).size.width / 1.25,
                              image: AssetImage('assets/images/1.png'),
                            ),
                          ],
                        )
                      ]),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
