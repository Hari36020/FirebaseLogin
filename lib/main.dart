import 'package:fineantlogin/signupscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'home.dart';



late final FirebaseApp app;
late final FirebaseAuth auth;
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  app = await Firebase.initializeApp();
  auth = FirebaseAuth.instanceFor(app: app);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.black
      ),
      home: const MyHomePage(title: 'Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController pswdController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        //add prefix icon
                        prefixIcon: const Icon(
                          Icons.person_outline_rounded,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(color: Colors.blue, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fillColor: Colors.grey,

                        hintText: "Email/Mobile",

                        //make hint text
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: "verdana_regular",
                          fontWeight: FontWeight.w400,
                        ),

                        //create lable
                        labelText: 'Email/Mobile',
                        //lable style
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: "verdana_regular",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      validator: (val){
                        if (val ==""){
                          return 'Enter a email';
                        }
                        return null;
                      }
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                      controller: pswdController,
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        //add prefix icon
                        prefixIcon: const Icon(
                          Icons.key_sharp,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(color: Colors.blue, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fillColor: Colors.grey,

                        hintText: "Password",

                        //make hint text
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: "verdana_regular",
                          fontWeight: FontWeight.w400,
                        ),

                        //create lable
                        labelText: 'Password',
                        //lable style
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: "verdana_regular",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      validator: (val){
                        if (val ==""){
                          return 'Enter a password';
                        }
                        return null;
                      }
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(

                      style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // background (button) color
                    foregroundColor: Colors.white, // foreground (text) color
                  ),onPressed: (){
                    //firebase

                    if(_formKey.currentState!.validate()){
                      mailSignIn(emailController.text,pswdController.text,context);
                    }
                  }, child: const Text("Login")),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // background (button) color
                      foregroundColor: Colors.white, // foreground (text) color
                    ),
                    child: Text("SignUp"),onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpScreen()));
                  },)
                ],
              )


            ],
          ),
        ),
      )

    );
  }


  static Future<String?> mailSignIn(String mail, String pwd,context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail, password: pwd);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home()));
    } on FirebaseAuthException catch (ex) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${ex.message}"),
      ));
      return "${ex.code}: ${ex.message}";
    }
  }


}
