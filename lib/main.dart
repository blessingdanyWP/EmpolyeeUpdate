import 'dart:io';

import 'package:EmployeeUpdate/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
Platform.isAndroid?
await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBSi0zSx1dQDqHxXNoeYqWqi8vUCCQRLfo",
      appId: "1:960869057909:android:5f1fc4096e3e0d1dfbff3c",
      messagingSenderId: "960869057909",
      projectId: "basicapp-864c0",
    ),
  )
  :await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      
        home: const Home(),
      
    );
  }
}
