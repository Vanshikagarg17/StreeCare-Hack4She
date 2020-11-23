import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:streecare/Components/styles.dart';



class StoreExploreView extends StatefulWidget {
  StoreExploreView({this.name,this.price,this.description,this.contact,this.image});
  final String name,image,price,description,contact;



  @override
  _StoreExploreViewState createState() => _StoreExploreViewState();
}

class _StoreExploreViewState extends State<StoreExploreView> {
  bool isPressed = false;
  DateFormat formatter = DateFormat.yMd();

  IconData down = Icons.keyboard_arrow_down,up = Icons.keyboard_arrow_up;
 

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
                  padding: EdgeInsets.only(left: 15, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child:Image.network(widget.image)
                      ),
                      Text('${widget.name}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black,),textAlign: TextAlign.justify),
                      //Text('${widget.age} years ${widget.gender}',style: TextStyle(fontSize: 15,color: Color(0xff756d7f)),),
                      SizedBox(height: 8,),
                      Text('Price : ${widget.price} ',style: kInfoText,),
                      SizedBox(height: 5,),


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
                            Text('Contact: ${widget.contact}', style: kInfoText,),
                         
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
