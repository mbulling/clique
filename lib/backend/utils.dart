import 'package:clique/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'message.dart';
import 'region.dart';

//The initializeFirebase() function is used to initialize the Firebase
//configuration in a Flutter application.
Future<void> initializeFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

//Firestore collection references

final regionsRef =
    FirebaseFirestore.instance.collection('regions').withConverter<Region>(
          fromFirestore: (snapshots, _) => Region.fromJson(snapshots.data()!),
          toFirestore: (message, _) => message.toJson(),
        );

//regions collection functions

Future<List<Region>> getAllRegions() async {
  QuerySnapshot<Region> querySnapshot = await regionsRef.get();
  List<Region> regionsList =
      querySnapshot.docs.map((doc) => doc.data()).toList();
  return regionsList;
}
