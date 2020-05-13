import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qrcodeapp/GenerateQrList.dart';

class ScanQRpage extends StatefulWidget{
  @override
  _ScanQRState createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQRpage> {
  String qrCodeResult = "Not Yet Scanned";
  bool firebaseupload = false;
  final fb = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    final Dref = fb.reference();
   return Scaffold(
     appBar: AppBar(
       title: Text ("Scanner"),
       centerTitle: true,
       backgroundColor: Color.fromRGBO(211, 84, 0, 1),
     ),

     body: Container(
       padding: EdgeInsets.all(20.0),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.stretch,
         children: <Widget>[
           SizedBox(height: 50.0,),
           Text("QR Scanner Result", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
             textAlign: TextAlign.center,
           ),
           SizedBox(height: 90.0,),
           Text(qrCodeResult,
             style: TextStyle(
               fontSize: 20.0,
             ),
             textAlign: TextAlign.center,
           ),
           SizedBox(height: 20.0,),

           FlatButton(
             padding: EdgeInsets.all(15.0),
             onPressed: () async{
               String ScannerCode = await BarcodeScanner.scan();
               setState(() {
                 qrCodeResult = ScannerCode;
                 firebaseupload = true;
                 print("Data Arrived" );
                 print(qrCodeResult);
               });
             },
             child: Text("Open Scanner",style: TextStyle(color: Color.fromRGBO(211, 84, 0, 1), fontWeight: FontWeight.bold),),
             shape: RoundedRectangleBorder(side: BorderSide(color: Color.fromRGBO(211, 84, 0, 1), width: 2.0), borderRadius: BorderRadius.circular(10.0)),
           ),

           SizedBox(height: 10.0,),

           FlatButton(
             padding: EdgeInsets.all(15.0),
             child: Text("Upload QR Code", style: TextStyle(color: Color.fromRGBO(211, 84, 0, 1), fontWeight: FontWeight.bold),),
             shape: RoundedRectangleBorder(side: BorderSide(color: Color.fromRGBO(211, 84, 0, 1), width: 2.0), borderRadius: BorderRadius.circular(10.0)),
            onPressed: () async{
               if(firebaseupload){
                 print("Ready to Save");
                 print(qrCodeResult);
                 Dref.child("QRCode").push().set({
                   "QR":qrCodeResult
                 });
                 showToast("QR Code updated");
                 qrCodeResult = "Scan Again";
               }else{
                 print("Not Ready to Save");
                 showToast("Not Yet Scanned, Please Scan");
               }
            },
           ),
         ],
       ),

     ),
   );
  }
}