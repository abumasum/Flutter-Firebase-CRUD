import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confrimPass = TextEditingController();
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
                onPressed: (){

                },
                
              ),
          ],
        ),
      ),
    );
  }
}