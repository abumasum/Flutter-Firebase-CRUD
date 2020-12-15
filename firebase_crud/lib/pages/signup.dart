import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/pages/verify.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confrimPass = TextEditingController();
  final snackBar = SnackBar(content: Text('Every field is required'));
  
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
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
        child: Column(
          children: <Widget>[
            SizedBox(height: 30.0,),
            TextField(
                controller: _name,
                decoration: InputDecoration(
                  border: null,
                  hintText: "Name",
                ),
              ),
              TextField(
                controller: _email,
                decoration: InputDecoration(
                  border: null,
                  hintText: "Email",
                ),
              ),
              TextField(
                controller: _password,
                decoration: InputDecoration(
                  border: null,
                  hintText: "Password",
                ),
              ),
              TextField(
                controller: _confrimPass,
                decoration: InputDecoration(
                  border: null,
                  hintText: "Confirm password",
                ),
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                color: Colors.blue,
                child: Text(
                  "SIGN UP",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () async{
                  String name, email, password, confirmPass;
                  name = _name.text;
                  email = _email.text;
                  password = _password.text;
                  confirmPass = _confrimPass.text;
                  if(name.isNotEmpty && email.isNotEmpty && password.isNotEmpty && confirmPass.isNotEmpty){
                    if(password == confirmPass){
                      try {
                           await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: email,
                            password: password
                          ).then((user) async{
                            User us = FirebaseAuth.instance.currentUser;
                            
                            if(us != null){
                              await us.sendEmailVerification();
                              FirebaseDatabase.instance.reference().child("users")
                              .push().set({
                                "name" : name,
                                "uid" : us.uid,
                                "email" : us.email
                              });
                              Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyEmail()));
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Something wrong"),)
                              );
                            }
                          });
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("The password provided is too weak."),)
                              );
                          } else if (e.code == 'email-already-in-use') {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("The account already exists for that email."),)
                              );
                          }
                        } catch (e) {
                          print(e);
                        }

                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Password did not match!"),)
                      );
                    }
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }

                },
                
              ),
          ],
        ),
      ),
    );
  }
}