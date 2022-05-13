import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'realtime_db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ensure initialisation
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  runApp(MaterialApp(
    home: realTimeDB(),
  ));
}


