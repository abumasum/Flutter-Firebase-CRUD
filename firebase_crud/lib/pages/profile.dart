import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = " ";
  int count = 0;
  final db = FirebaseDatabase.instance.reference();
  StreamSubscription<Event> _onTodoAddedSubscription;
  StreamSubscription<Event> _onCountSubscription;
  Query nameQuery, countQuery;
  @override
  void initState() { 
    super.initState();
    nameQuery = db.child("users").orderByChild("uid").equalTo(FirebaseAuth.instance.currentUser.uid);
    countQuery = db.child("todo").orderByChild("userId").equalTo(FirebaseAuth.instance.currentUser.uid);
     _onTodoAddedSubscription = nameQuery.onChildAdded.listen(readName);
     _onCountSubscription = countQuery.onChildAdded.listen(countTodo);
    
  }

  @override
  void dispose() { 
    _onTodoAddedSubscription.cancel();
    _onCountSubscription.cancel();
    super.dispose();
  }
  readName(Event event){
      setState(() {
        name = event.snapshot.value["name"];       
      });     
  }

  countTodo(Event event){
    setState(() {
      Map data = event.snapshot.value;
      count = data.length;
    });
  }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple[100], Colors.grey[300]]
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Align(
              child: Container(
                padding: EdgeInsets.all(5.0),
                child: Icon(
                  Icons.person,
                  size: 100,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400
                  ),
                ),
                IconButton(icon: Icon(Icons.edit), onPressed: (){

                })
              ],
            ),
            Divider(
              height: 2.0,
              color: Colors.black,
            ),
            Text(
                  name,
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600
                  ),
                ),
            SizedBox(height: 40.0,),
            Text(
                  'ToDo Count',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400
                  ),
            ),
            Divider(
              height: 20.0,
              color: Colors.black,
            ),
            Text(
                  count.toString(),
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600
                  ),
                ),
          ],
        ),
      ),
    );
  }
}