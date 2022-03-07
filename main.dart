import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_firestore_offline/services/database.dart';


//- package:lorem_ipsum not null safety
// run>edit configurations> addtl run args> --no-sound-null-safety

//----Initializing Firebase --------
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings();
  runApp(MaterialApp(home: Flutter_offline()));
}
// -----------------------------

class Flutter_offline extends StatefulWidget {
  @override
  State<Flutter_offline> createState() => _Flutter_offlineState();
}

class _Flutter_offlineState extends State<Flutter_offline> {

  @override
  Widget build(BuildContext context) {
//-------------------calling firestore ---------
    final DatabaseService data = new DatabaseService();

//--------------------------------------------------------
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testing Firestore Offline'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: data.flutterCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(!snapshot.hasData){
          return const Center(
            child:CircularProgressIndicator(),
          );
        }
        //------------fetching firestore live --------
        return ListView(
          children: snapshot.data!.docs.map((document){
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width /1.2,
              height: MediaQuery.of(context).size.height / 12,
              child:Column(
                children: [
                  Text(
                    "Document: "+document['name'],
                    style: const TextStyle(fontSize:20),
                  ),
                  Text(
                    "Date: "+document['date'].toDate().toString(),
                    style: const TextStyle(fontSize:20),
                  ),
                ],
              ),
            ),
          );
          }).toList(),
        );
        }
      ),
      // -----------------------------------------
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //upload data to firestore
          setState(() {
            data.addData();
          });
        },
        child: const Icon(Icons.upload),
      ),
    );
  }

  }



