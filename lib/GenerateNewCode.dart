import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateNewCode extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => GenerateNewState();
}

class GenerateNewState  extends State<GenerateNewCode>{
  String qrData = "FlutterQRApp";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
        backgroundColor: Color.fromRGBO(211, 84, 0, 1),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            QrImage(
              //plce where the QR Image will be shown
              padding: EdgeInsets.all(50.0),
              data: qrData,
            ),
            SizedBox(
              height: 30.0,
            ),
            TextField(
              controller: qrdataFeed,
              decoration: InputDecoration(
                hintText: "Input your link or data",
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
              child: FlatButton(
                padding: EdgeInsets.all(15.0),
                onPressed: () async {

                  if (qrdataFeed.text.isEmpty) {        //a little validation for the textfield
                    setState(() {
                      qrData = "";
                    });
                  } else {
                    setState(() {
                      qrData = qrdataFeed.text;
                    });
                  }

                },
                child: Text('Generate QR Code', style: TextStyle(color: Color.fromRGBO(211, 84, 0, 1), fontWeight: FontWeight.bold),
                ),
                shape: RoundedRectangleBorder(side: BorderSide(color: Color.fromRGBO(211, 84, 0, 1), width: 2.0), borderRadius: BorderRadius.circular(10.0)),
              ),
            )
          ],
        ),
      ),
    );
  }
  final qrdataFeed = TextEditingController();
}
