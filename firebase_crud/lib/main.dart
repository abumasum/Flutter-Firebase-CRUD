import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/pages/home_page.dart';
import 'package:firebase_crud/pages/login.dart';
import 'package:firebase_crud/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: App(),
    );
  }
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return SnackBar(
            content: Text("Something went wrong"),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          User user = FirebaseAuth.instance.currentUser;
          if(user != null){
            //show home
            return Home();
          }else{
            //wellcome
            return Login();
          }
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Splash();
      },
    );
  }
}