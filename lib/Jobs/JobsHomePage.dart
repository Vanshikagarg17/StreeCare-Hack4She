import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'my_flutter_app_icons.dart' as customIcons;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:streecare/Components/my_flutter_app_icons.dart';
import 'package:streecare/Jobs/CreateJobs.dart';
import 'package:streecare/Jobs/JobExplore.dart';
import 'package:streecare/Meetups/CreateMeetup.dart';
import 'package:streecare/Meetups/MeetUpBoard.dart';
import 'package:streecare/Meetups/MeetUpExplore.dart';

class JobsHomePage extends StatefulWidget {
  @override
  _JobsHomePageState createState() => _JobsHomePageState();
}

class _JobsHomePageState extends State<JobsHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xfffe82a7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Jobs',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            Center(
              child: Text(
                'What are your next steps and goals?\n & Explore jobs opportunities near you!',
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
                                      title: Text('Post Jobs',
                                          style: TextStyle(
                                              color: Color(0xff75c7fb))),
                                      trailing: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CreateJobs()));
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xff75c7fb),
                                                shape: BoxShape.circle),
                                            child: Icon(Icons.arrow_forward)),
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
                                        'Explore Jobs',
                                        style:
                                            TextStyle(color: Color(0xff75c7fb)),
                                      ),
                                      trailing: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      JobExplore()));
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xff75c7fb),
                                                shape: BoxShape.circle),
                                            child: Icon(Icons.arrow_forward)),
                                      ),
                                    ),
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
                            width: MediaQuery.of(context).size.width / 1.09,
                            image: AssetImage('assets/images/ww.png'),
                          ),
                        ],
                      )
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
