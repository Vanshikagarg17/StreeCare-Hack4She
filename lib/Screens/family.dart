import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Family extends StatefulWidget {
  @override
  FamilyState createState() => new FamilyState();
}

class FamilyState extends State<Family> {
  double screenHeight;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
          "https://www.youtube.com/watch?v=kz6tCyKQDEc"),
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    YoutubePlayerController _controller1 = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
          "https://www.youtube.com/watch?v=raD6bhrjwes"),
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
      ),
    );

    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xfffe82a7),
      body: Container(
        child: new SingleChildScrollView(
          child: new ConstrainedBox(
            constraints: new BoxConstraints(),
            child: new Container(
              margin: EdgeInsets.all(20),
              child: new Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Card(
                          child: ListTile(
                            leading: Image.asset("assets/images/calendar.png"),
                            title: Text('Meetups'),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 20),
                            // subtitle: Text(''),
                            // isThreeLine: true,
                            trailing: RaisedButton(
                                child: Text('Go'),
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    side: BorderSide(color: Colors.black)),
                                onPressed: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           MeetUpsHomePage()),
                                  // );
                                }),
                          ),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Text(
                            'Watch these videos to get more information about family planning',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    YoutubePlayer(
                      controller: _controller,
                      liveUIColor: Colors.amber,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    YoutubePlayer(
                      controller: _controller1,
                      liveUIColor: Colors.amber,
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    // add form here
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
