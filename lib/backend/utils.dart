import 'package:clique/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'message.dart';
import 'region.dart';

///The initializeFirebase() function is used to initialize the Firebase
///configuration in a Flutter application.
Future<void> initializeFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

///Firestore collection references

final regionsRef =
    FirebaseFirestore.instance.collection('regions').withConverter<Region>(
          fromFirestore: (snapshots, _) => Region.fromJson(snapshots.data()!),
          toFirestore: (region, _) => region.toJson(),
        );

final messageRef =
    FirebaseFirestore.instance.collection('messages').withConverter<Message>(
          fromFirestore: (snapshots, _) => Message.fromJson(snapshots.data()!),
          toFirestore: (message, _) => message.toJson(),
        );

/// Retrieves all the regions from Firestore and returns them as a list of [Region] objects.
Future<List<Region>> getAllRegions() async {
  QuerySnapshot<Region> querySnapshot = await regionsRef.get();
  List<Region> regionsList =
      querySnapshot.docs.map((doc) => doc.data()).toList();
  return regionsList;
}

/// Creates a new region document in Firestore with the given parameters.
Future<void> createRegion(
    String name, double latitude, double longitude, double radius) async {
  await regionsRef.add(Region(latitude, longitude, radius, name));
}

/// Retrieves a stream of messages from Firestore that belong to the specified region.
Stream<List<Message>> getMessages(String regionName) {
  return messageRef
      .where('region', isEqualTo: regionName)
      .orderBy('time', descending: true)
      .snapshots()
      .map((querySnapshot) =>
          querySnapshot.docs.map((doc) => doc.data()).toList());
}

/// Retrieves the current location of the device using the Geolocator package.
Future<Position> getPosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition();
}
