import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class VerifyEmail extends StatefulWidget {

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  void initState(){ 
    super.initState();
    FirebaseAuth.instance.authStateChanges()
    .listen((User user) {
      if(user.emailVerified){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      }
     });
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Ceck your email to verify this account'
        ),
      ),
    );
  }
}