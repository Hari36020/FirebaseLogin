import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

        appBar: AppBar(
          title: const Text("Home"),
        ),
        body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome Home"),
            TextButton(onPressed: () async {
              final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
              await _firebaseAuth.signOut().then((value){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MyApp()));
              });
            }, child: Text("Logout"))
          ],
        )
    ));
  }
}
