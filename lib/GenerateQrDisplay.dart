import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcodeapp/GenerateNewCode.dart';

class GenerateQrDisplay extends StatefulWidget{

  final String data;
  GenerateQrDisplay(this.data);

  @override
  State<StatefulWidget> createState() => GenerateQrDisplayState();
}
class GenerateQrDisplayState extends State<GenerateQrDisplay>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Generated QR Code"),
        backgroundColor: Color.fromRGBO(211, 84, 0, 1),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            SizedBox(
              height: 50.0,
            ),

            Text(widget.data,textAlign: TextAlign.center,style: new TextStyle(fontSize: 15.0,decoration: TextDecoration.underline,color: Color.fromRGBO(211, 84, 0, 1),fontWeight: FontWeight.bold),),

            QrImage(
              //plce where the QR Image will be shown
              padding: EdgeInsets.all(30.0),
              data: widget.data,
            ),
            SizedBox(
              height: 60.0,
            ),

            FlatButton(
              padding: EdgeInsets.all(20.0),
              child: Text('Generate New QR Code',style: TextStyle(color: Color.fromRGBO(211, 84, 0, 1), fontWeight: FontWeight.bold),
              ),
              shape: RoundedRectangleBorder(side: BorderSide(color: Color.fromRGBO(211, 84, 0, 1), width: 2.0), borderRadius: BorderRadius.circular(10.0)),
              onPressed: () async{
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => GenerateNewCode()));
              },
            )
          ],
        ),
      ),
    );
  }
  final qrdataFeed = TextEditingController();
}