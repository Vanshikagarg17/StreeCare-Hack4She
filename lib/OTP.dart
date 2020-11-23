//AKHIL AND RAHUL CODE, IF ANY ERROR IN MOHIT'S CODE, TURN THIS ON
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:adobe_xd/page_link.dart';
import 'package:flutter/widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:streecare/EnterMobile.dart';
import 'package:streecare/Screens/homepage.dart';

class SizeConfig {
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

class OTP extends StatefulWidget {
  final String phone;

  OTP({Key key, @required this.phone}) : super(key: key);

  @override
  _OTPState createState() => _OTPState(phone);
}

class _OTPState extends State<OTP> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType> errorController;

  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  TextEditingController controller;
  String otp, a;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  bool loading = false;

  final String phone;

  _OTPState(this.phone);

  final code = TextEditingController();
  void initState() {
    loginUser(context);
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  Future<bool> loginUser(BuildContext context) async {
    _auth.verifyPhoneNumber(
        phoneNumber: "+91" + widget.phone.trim(),
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          setState(() {
            //loading = true;
          });
          //Navigator.of(context).pop();
          try {
            AuthResult result = await _auth.signInWithCredential(credential);
            user = result.user;
          } catch (e) {
            print(e);
          }

          //  await result.user.linkWithCredential(credential1);
          if (user != null) {
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => (Homepage())));
          } else {
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (AuthException exception) {
          print(exception.message);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          a = verificationId;
        },
        codeAutoRetrievalTimeout: null);
  }

  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StreeCare',
      home: Scaffold(
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
                          height: SizeConfig.blockSizeHorizontal * 42,
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
                                PageLink(
                                  child: Icon(
                                    FontAwesomeIcons.arrowLeft,
                                    color: Colors.white,
                                  ),
                                  links: [
                                    PageLinkInfo(
                                      transition: LinkTransition.SlideRight,
                                      ease: Curves.easeOut,
                                      duration: 0.3,
                                      pageBuilder: () => EnterMobile(),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 85,
                                  height: SizeConfig.blockSizeVertical * 13,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                'Tell me something that\nonly two of us know',
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
                  height: SizeConfig.blockSizeVertical * 3,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Enter The Code To Verify Your Phone',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 18,
                      color: const Color(0xff43525b),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Image.asset('assets/images/Phone2.png'),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 3,
                ),

                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 60,
                  height: SizeConfig.blockSizeVertical * 5,
                  child: Text(
                    'We\'ve sent your an SMS with a code to\n' + phone,
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 12,
                      color: const Color(0xff43525b),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),

                /* Container(
                  width: SizeConfig.blockSizeHorizontal * 60,
                  height: SizeConfig.blockSizeVertical * 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: const Color(0xffffffff),
                    border:
                        Border.all(width: 1.0, color: const Color(0xff707070)),
                  ),
                  child: SizedBox(
                    //height: 100,
                    child: TextField(
                      controller: code,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: '51234'),
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                    ),
                  ),
                ), */
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      textStyle: TextStyle(fontFamily: 'Lato'),
                      appContext: context,
                      pastedTextStyle: TextStyle(
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lato'),
                      length: 6,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v.length < 6) {
                          return "Enter all Digits properly";
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                        inactiveColor: Color(0xfffe82a7),
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      // backgroundColor: Colors.blue.shade50,
                      // enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      onCompleted: (v) {
                        // print("Done");
                      },
                      // onTap: () {
                      // },
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        return true;
                      },
                    )),
                // OTPTextField(
                //   length: 6,
                // ),
                SizedBox(
                  height: SizeConfig.blockSizeHorizontal * 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => OTP(phone: phone)));
                  },
                  child: Text(
                    "Resend OTP",
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 12,
                        color: const Color(0xff43525b)),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeHorizontal * 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => EnterMobile()));
                  },
                  child: Text(
                    "Change Phone Number",
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 12,
                        color: const Color(0xff43525b)),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeHorizontal * 6,
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
                      FontAwesomeIcons.arrowRight,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    // final code1 = code.text.trim();
                    AuthCredential credential = PhoneAuthProvider.getCredential(
                        verificationId: a, smsCode: textEditingController.text);
                    AuthResult result =
                        await _auth.signInWithCredential(credential);

                    FirebaseUser user = result.user;

                    if (user != null) {
                      // Navigator.pop(context);
                      pref.setBool('phone', true);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Homepage()));
                    } else {
                      print("Error");
                    }

                    ////BUTTON ON PRESS
                  },
                ),
              ],
            ),
          )),
    );
  }
}

class OtpTextField extends StatelessWidget {
  const OtpTextField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 11,
      height: SizeConfig.blockSizeVertical * 7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xffffffff),
        border: Border.all(
          width: 2,
          color: const Color(0xfffe82a7),
        ),
        boxShadow: [
          BoxShadow(
              color: const Color(0x29000000),
              offset: Offset(3, 3),
              blurRadius: 6),
        ],
      ),
      child: SizedBox(
        //height: 100,
        child: TextField(
          textAlignVertical: TextAlignVertical.bottom,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, fontFamily: 'Lato', fontWeight: FontWeight.w700),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '*',
            counterText: "",
          ),
          keyboardType: TextInputType.number,
          maxLength: 1,
        ),
      ),
    );
  }
}
