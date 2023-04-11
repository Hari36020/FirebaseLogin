import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formSignUpKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController pswdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("SignUp"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Form(
            key: _formSignUpKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                    const SizedBox(
                      height: 30,
                    ),
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
                const SizedBox(
                  height: 70,
                ),

                ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // background (button) color
                      foregroundColor: Colors.white, // foreground (text) color
                    ),
                    onPressed: (){
                  //firebase

                  if(_formSignUpKey.currentState!.validate()){
                    mailRegister(emailController.text,pswdController.text).then((value) {
                      Navigator.pop(context);
                    });
                  }
                }, child: Text("Register")),


              ],
            ),
          ),
        )

    );
  }
  static Future<String?> mailRegister(String mail, String pwd) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: mail, password: pwd);
      return null;
    } on FirebaseAuthException catch (ex) {
      return "${ex.code}: ${ex.message}";
    }
  }
}
