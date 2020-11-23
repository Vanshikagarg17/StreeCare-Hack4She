import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:streecare/Components/styles.dart';



class JobExploreView extends StatefulWidget {
  JobExploreView({this.role,this.description,this.city,this.mobile,this.posts,this.salary,this.duration,this.id,this.type});
  final String role,description,city,mobile,posts,salary,duration,id,type;



  @override
  _JobExploreViewState createState() => _JobExploreViewState();
}

class _JobExploreViewState extends State<JobExploreView> {
  bool isPressed = false;
  DateFormat formatter = DateFormat.yMd();

  IconData down = Icons.keyboard_arrow_down,up = Icons.keyboard_arrow_up;
  _register() async {
    final _user = await FirebaseAuth.instance.currentUser();
    final _uid = _user.uid;
    Firestore.instance.collection('MeetUps').document(widget.id).updateData({
      'attendees': FieldValue.arrayUnion([_uid])
    }).then((value) {
      Fluttertoast.showToast(
          msg: "Successfully Registered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          fontSize: 16.0
      );
    });
  }
  _delete() async {
    print("hii");
    final _user = await FirebaseAuth.instance.currentUser();
    final _uid = _user.uid;
    Firestore.instance.collection('Jobs').document(widget.id).delete().then((value){
    Fluttertoast.showToast(
    msg: "Successfully Deleted the event",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.pink,
    textColor: Colors.white,
    fontSize: 16.0
    );
    });
  }
  @override
  Widget build(BuildContext context) {
    //DateTime recoverDate = widget.isRecovered?widget.recoverDate.toDate():DateTime.now();
  //  DateTime lastTested = widget.lastTested.toDate();
    return Container(
        decoration: BoxDecoration(
          color: Color(0xfffce4ec),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: InkWell(
          onTap: (){
//            var code;
//            if(puid.hashCode > uid.hashCode)
//              code = '$puid-$uid';
//            else
//              code = '$uid-$puid';
//            Firestore.instance.collection('ongoing').document(puid).collection(puid).document(code).setData({
//              'image':img,
//              'nickname':name,
//              'msg':msg,
//              'time':formatter.format(DateTime.now()),
//              'uid':uid
//            });
//            Navigator.push(context, MaterialPageRoute(builder: (context)=> Chat(code: code,image: img,name: name,puid: puid,)));
          },
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${widget.role}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black,),textAlign: TextAlign.justify),
                      //Text('${widget.age} years ${widget.gender}',style: TextStyle(fontSize: 15,color: Color(0xff756d7f)),),
                      SizedBox(height: 8,),
                      Text('Salary: ${widget.salary} ',style: kInfoText,),
                      SizedBox(height: 5,),
                      Text('Duration: ${widget.duration}', style: kInfoText,)

                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isPressed = !isPressed;
                        });
                      },
                      child: Icon(
                        isPressed?up:down,
                        size: 30,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Visibility(
                  visible: isPressed,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 5,),
                            Text('Contact: ${widget.mobile}', style: kInfoText,),
                            SizedBox(height: 5,),
                            Text('No of posts: ${widget.posts}', style: kInfoText,),
                            SizedBox(height: 5,),
                            Text('City: ${widget.city},', style: kInfoText,),
                            SizedBox(height: 5,),
                            Text('More Info:',style: kInfoText,),
                            SizedBox(height: 2,),
                            Text('${widget.description}', style: kInfoText,),
                            SizedBox(height: 2,),

                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
