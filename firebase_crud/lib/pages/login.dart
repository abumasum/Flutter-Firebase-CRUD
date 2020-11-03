import 'package:firebase_crud/pages/signup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CRUD Operation",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          children: <Widget>[
            SizedBox(height: 30.0,),
            TextField(
              controller: email,
              decoration: InputDecoration(
                border: null,
                hintText: "Email",
              ),
            ),
            TextField(
              controller: password,
              decoration: InputDecoration(
                border: null,
                hintText: "Password",
              ),
            ),
            SizedBox(height: 20.0,),
            RaisedButton(
              color: Colors.blue,
              child: Text(
                "LOGIN",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: (){

              },
              
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "New here? ",
                        style: TextStyle(
                          color: Colors.black,
                        )
                      ),
                      TextSpan(
                        text: "Create an account",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                        recognizer: TapGestureRecognizer()
                        ..onTap = (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
                        }
                      ),
                    ]
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}