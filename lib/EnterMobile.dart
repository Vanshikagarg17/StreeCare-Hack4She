import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:adobe_xd/page_link.dart';
import 'package:flutter/widgets.dart';
import 'package:streecare/OTP.dart';

class SizeConfig1 {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}

class EnterMobile extends StatefulWidget {
  // final AuthCredential credential;
  // EnterMobile({Key key, @required this.credential}) : super(key: key);
  @override
  _EnterMobileState createState() => _EnterMobileState();
}

class _EnterMobileState extends State<EnterMobile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final phone = TextEditingController();
  // final AuthCredential credential;
  // _EnterMobileState(this.credential);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig1().init(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UniQ',
      home: Scaffold(
          key: _scaffoldKey,
          //resizeToAvoidBottomPadding: false,
          backgroundColor: const Color(0xffffffff),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: SizeConfig1.blockSizeHorizontal * 42,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(-1.52, 1.0),
                              end: Alignment(1.13, -0.95),
                              colors: [
                                const Color(0xfffe82a7),
                                const Color(0xfffe82a7),
                              ],
                              stops: [0.0, 1.0],
                            ),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                // PageLink(
                                //   child: Icon(
                                //     FontAwesomeIcons.arrowLeft,
                                //     color: Colors.white,
                                //   ),
                                //   links: [
                                //     PageLinkInfo(
                                //       transition: LinkTransition.SlideRight,
                                //       ease: Curves.easeOut,
                                //       duration: 0.3,
                                //       pageBuilder: () => SignUp(),
                                //     ),
                                //   ],
                                // ),
                                SizedBox(
                                  width: SizeConfig1.blockSizeHorizontal * 85,
                                  height: SizeConfig1.blockSizeVertical * 8,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                'We\'re just making a \nsecure community ',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 22,
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig1.blockSizeVertical * 3,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Please Enter Your Valid Mobile Number',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 18,
                      color: const Color(0xff43525b),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width / 2,
                        image: AssetImage('assets/images/w2.png')),
                  ],
                ),
//                SizedBox(height: SizeConfig1.blockSizeVertical * 3),
                Container(
                  width: SizeConfig1.blockSizeHorizontal * 70,
                  height: SizeConfig1.blockSizeVertical * 7.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: const Color(0xffffffff),
                    border:
                        Border.all(width: 1.0, color: const Color(0xff707070)),
                  ),
                  child: SizedBox(
                    child: Row(
                      children: [
                        Container(
                          height: SizeConfig1.blockSizeVertical * 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(3.0)),
                            color: Color(0xff555555),
                          ),
                          child: Center(
                            child: IconButton(
                              icon: Icon(
                                FontAwesomeIcons.mobileAlt,
                                color: Colors.white,
                              ),
                              onPressed: null,
                            ),
                          ),
                        ),
                        Flexible(
                          child: TextField(
                            controller: phone,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              border: InputBorder.none,
                              hintText: '9876544231',
                              counterText: "",
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig1.blockSizeVertical * 3,
                ),
                SizedBox(
                  width: SizeConfig1.blockSizeHorizontal * 70,
                  child: Text(
                    'You\'ll get an OTP on this number',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 12,
                      color: const Color(0xff43525b),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: SizeConfig1.blockSizeVertical * 2,
                ),
                FlatButton(
                  child: Container(
                    width: 66,
                    height: 66,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(64),
                      gradient: LinearGradient(
                        begin: Alignment(-1.35, 2.14),
                        end: Alignment(1.13, -2.03),
                        colors: [
                          const Color(0xfffe82a7),
                          const Color(0xfffe82a7),
                        ],
                        stops: [0.0, 1.0],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  onPressed: () {
                    if (!(phone.text.length < 10)) {
                      print(phone.text);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OTP(
                                  phone: phone.text,
                                )),
                      );
                    } else {
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text(
                          "Enter valid phone number",
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Lato'),
                        ),
                        elevation: 0,
                        duration: Duration(seconds: 2),
                        backgroundColor: Color(0xfffe82a7),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                topLeft: Radius.circular(5))),
                      ));
                    }
                  },
                ),
              ],
            ),
          )),
    );
  }
}
