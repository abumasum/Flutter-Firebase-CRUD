import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _name = TextEditingController();

  final _email = TextEditingController();

  final _mobile = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data entry'
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
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
                  controller: _mobile,
                  decoration: InputDecoration(
                    border: null,
                    hintText: "Mobile number",
                  ),
                ),
                Expanded(
                  child:Align(
                    alignment: Alignment.bottomCenter,
                    child: RaisedButton(
                      child: Text('Save data'),
                      onPressed: (){
                        User user = FirebaseAuth.instance.currentUser;
                        FirebaseDatabase.instance.reference().child('data')
                        .push().set({
                          "name" : _name.text,
                          "email" : _email.text,
                          "mobile" : _mobile.text,
                          "uid" : user.uid
                        }).then((value){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Data inserted successfully'),)
                          );
                          setState(() {
                            _name.text = "";
                            _email.text = "";
                            _mobile.text = "";
                          });
                        });
                      },
                    ),
                  )
                )
          ],
        ),
      ),
    );
  }
}