import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qrcodeapp/HomePage.dart';
import 'package:qrcodeapp/Qrdata.dart';
import 'package:qrcodeapp/GenerateQrDisplay.dart';

class GeneratePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => GeneratePageState();
}
void showToast(String msgs){

  Fluttertoast.showToast(
      msg: msgs,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.grey,
      textColor: Colors.black
  );
}
class GeneratePageState extends State<GeneratePage> {
  String qrcode = "FlutterTask";
  final fb = FirebaseDatabase.instance;
  List<Qrdata> list = new List();
  Qrdata qrdata;

  @override
  void initState() {
    super.initState();
    showToast("Loading.....");
    firebasedata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('OR Code List'),
          backgroundColor: Color.fromRGBO(211, 84, 0, 1),
        ),

        body: new Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              SizedBox(height:15.0),

              Text("List of QR Code from Firebase", textAlign: TextAlign.center,style: new TextStyle(fontSize: 18.0,decoration: TextDecoration.underline,color: Colors.indigo,fontWeight: FontWeight.bold),),

              SizedBox(height:5.0),

              new Expanded(child: new ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.all(5.0),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index)  {
                    return GestureDetector(
                    onTap: () {
                      String value = list[index].Qr;
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GenerateQrDisplay(value) ));
                      },
                        child: Container(
                          child: new Card(
                            elevation: 5,
                           child: Padding(
                             padding: EdgeInsets.all(6),
                           child: new Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Padding(padding: new EdgeInsets.all(5.0)),
                                  new Text(list[index].Qr,style: new TextStyle(fontSize: 18),)
                                ],
                              ),
                            )
                          )
                        )
                    );
                  }
              )),
            ],
          ),
        )
    );
  }

   firebasedata() async {
    final Dref = fb.reference().child("QRCode");
    await Dref.once().then((DataSnapshot datasnap) {
      if (datasnap.value != null){
        this.setState(() {
          for (var value in datasnap.value.values) {
            list.add(new Qrdata.fromJson(value));
          }
        });
      }else{
        showToast("Please upload QR code");
      }
    });
  }
}
