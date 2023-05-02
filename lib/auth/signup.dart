import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// import 'package:;

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var myusername,mypassword,myemail;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // final fi =FirebaseFirestore.instance;

  // final userFR = fi.collection("users");
      
  signUp() async {
    var formdata = formstate.currentState;
    if(formdata!.validate()){
      print("valid");
      formdata.save();
      
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: myemail,
          password: mypassword
        );
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          AwesomeDialog(context: context , title: 'Error' , body: Text("The password provided is too weak"))..show();
          // AweasomeDialog();
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use')
          AwesomeDialog(context: context , title: 'Error' , body: Text("The account already exists for that email"))..show(); {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }else{
      print("not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: 100),
          Center(child: Image.asset(
            "assets/images/Logo.png",
          )),
            Container(
              padding: EdgeInsets.all(20),
              child: Form(
                key: formstate,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      onSaved: (val){
                        myusername= val;
                      },
                      validator: (val){
                        if(val == null || val.isEmpty){
                          return "Enter a username";
                        }
                        if(val.length > 100 ){
                          return "Value can't be larger than 100 letter."; 
                        }
                        if(val.length < 2 ){
                          return "Value can't be less than 2 letter."; 
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "Username",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          )),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      onSaved: (val){
                        myemail= val;
                      },
                      validator: (val){
                        if(val == null || val.isEmpty){
                          return "Enter an Email";
                        }
                        if(val.length > 100 ){
                          return "Email can't be larger than 100 letter."; 
                        }
                        if(val.length < 2 ){
                          return "Email can't be less than 2 letter."; 
                        }
                        if(!val.contains("@")){
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "email",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          )),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      onSaved: (val){
                        mypassword= val;
                      },
                      validator: (val){
                        if(val == null || val.isEmpty){
                          return "Enter Password";
                        }
                        if(val.length > 100 ){
                          return "Password can't be larger than 100 letter."; 
                        }
                        if(val.length < 2 ){
                          return "Password can't be less than 2 letter."; 
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text("Already have Account? "),
                          InkWell(
                            onTap: () {
                              // Navigator.of(context).pushNamed("login");
                              context.pushReplacement("/login");
                              print("login");
                            },
                            child: Text(
                              "Click Here",
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: ElevatedButton(
                        child: const Text("Sign Up"),
                        onPressed: () async {
                          var response = await signUp();

                          print("==========================");
                          print("object");
                          print(response.user);

                          if(response!=null){
                            FirebaseFirestore.instance.collection("users").doc(response.user.uid).set({
                              "email":myemail,
                              "name":myusername,
                            });
                            context.pushReplacement("/");
                          }else{
                            print("Sign Up Faild");
                          }
                          print("==========================");
                        },
                        style: ElevatedButton.styleFrom(
                          // backgroundColor: Colors.red,
                          textStyle: const TextStyle(
                          fontSize: 20,
                        )),
                      ),
                    )
                  ],
                ),
              ),
            
            ),
        ],
      ),
    );
  }
}
