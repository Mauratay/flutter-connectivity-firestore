import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:flutter_firestore_offline/services/connectivity.dart';

class DatabaseService {

//------------ calling connectivity check-----------------
  final Connection online = new Connection();
//--------------------------------------------------------

  final CollectionReference flutterCollection =
  FirebaseFirestore.instance.collection('flutterfirestore');

  Future addData() async {
    if(online.isInternet() == 'true'){
      return await flutterCollection.doc(loremIpsum(words:2)).set({
        'name': loremIpsum(words: 2),
        'date': FieldValue.serverTimestamp(),
      });
    }else{
      return 'Do nothing';
    }

  }
}




