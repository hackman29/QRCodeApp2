import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:qrcodeapp/ScanQr.dart';
import 'package:qrcodeapp/GenerateQrList.dart';
import 'package:qrcodeapp/GenerateNewCode.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends  State<HomePage>{

   String ConnectionStatus;

  @override
  void initState() {
    super.initState();
    final Connectivity _conn  = new Connectivity();
    StreamSubscription<ConnectivityResult> _connsub;
    _connsub = _conn.onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        ConnectionStatus = result.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(211, 84, 0, 1),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20.0),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FlatButton(
              padding: EdgeInsets.all(15.0),
              child: Text('Scan QR Code', style: TextStyle(color: Color.fromRGBO(211, 84, 0, 1), fontWeight: FontWeight.bold),
              ),
              shape: RoundedRectangleBorder(side: BorderSide(color: Color.fromRGBO(211, 84, 0, 1), width: 2.0), borderRadius: BorderRadius.circular(10.0)),
              onPressed: () async{

                if(ConnectionStatus == "ConnectivityResult.none"){
                  showToast("Please enable your network");
                }else {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ScanQRpage()));
                }
              },
            ),

            SizedBox(height: 25.0,),

            FlatButton(
              padding: EdgeInsets.all(15.0),
              child: Text('QR Code List',style: TextStyle(color: Color.fromRGBO(211, 84, 0, 1), fontWeight: FontWeight.bold),
              ),
              shape: RoundedRectangleBorder(side: BorderSide(color: Color.fromRGBO(211, 84, 0, 1), width: 2.0), borderRadius: BorderRadius.circular(10.0)),
              onPressed: () async{
                print('Now you Navigate generater');
                print(ConnectionStatus);
                if(ConnectionStatus == "ConnectivityResult.none"){
                  showToast("Please enable your network");
                }else{
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => GeneratePage()));
                }
              },
            ),

            SizedBox(height: 25.0,),

            FlatButton(
              padding: EdgeInsets.all(15.0),
              child: Text('Generate New QR Code',style: TextStyle(color: Color.fromRGBO(211, 84, 0, 1), fontWeight: FontWeight.bold),
              ),
              shape: RoundedRectangleBorder(side: BorderSide(color: Color.fromRGBO(211, 84, 0, 1), width: 2.0), borderRadius: BorderRadius.circular(10.0)),
              onPressed: () async{
                print('Now you Navigate generater');
                if(ConnectionStatus == "ConnectivityResult.none"){
                     showToast("Please enable your network");
                }else{
                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => GenerateNewCode()));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}