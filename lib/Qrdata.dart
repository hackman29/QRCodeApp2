import 'package:firebase_database/firebase_database.dart';

class Qrdata{
  String Qr;
  Qrdata(this.Qr);

  Qrdata.fromJson(var value){
    this.Qr = value['QR'];
  }
}

