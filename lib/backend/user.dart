import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

// Generate user identifier
String generateUserIdentity() {
  Random random = Random();
  return (random.nextInt(999999)).toString();
}

// Retrieve the userIdentity from local storage
Future<String> retrieveUser() async {
  final prefs = await SharedPreferences.getInstance();
  String userIdentity = prefs.getString('userIdentity') ?? "";

  if (userIdentity == "") {
    userIdentity = generateUserIdentity();
    await prefs.setString('userIdentity', userIdentity);
  }

  return userIdentity;
}
