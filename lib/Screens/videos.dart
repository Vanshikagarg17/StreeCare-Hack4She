import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ThirdScreen extends StatefulWidget {
  @override
  ThirdScreenState createState() => new ThirdScreenState();
}

class ThirdScreenState extends State<ThirdScreen> {
  double screenHeight;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
          "https://www.youtube.com/watch?v=JIAzI29-otM"),
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    YoutubePlayerController _controller1 = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
          "https://www.youtube.com/watch?v=WaOxj6hKulY"),
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
      ),
    );
    YoutubePlayerController _controller2 = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
          "https://www.youtube.com/watch?v=RDQviTbHmOg"),
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
                      height: 40,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                          child: Text(
                            'Watch these videos to get more information about symptoms and self examination',
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
                    YoutubePlayer(
                      controller: _controller2,
                      liveUIColor: Colors.amber,
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
