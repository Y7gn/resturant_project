import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:developer' as devtools show log;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var mypassword, myemail;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  signIn() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      print("valid");
      formdata.save();

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: myemail, password: mypassword);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          AwesomeDialog(
              context: context,
              title: 'Error',
              body: Text("No user found for that email."))
            ..show();

          // print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          AwesomeDialog(
              context: context,
              title: 'Error',
              body: Text("Wrong password provided for that user."))
            ..show();
        }
      }
    } else {
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
          Center(
              child: Image.asset(
            "assets/images/Logo.png",
          )),
          Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: formstate,
              child: Column(
                children: [
                  TextFormField(
                    onSaved: (val) {
                      myemail = val;
                    },
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Enter an Email";
                      }
                      if (val.length > 100) {
                        return "Email can't be larger than 100 letter.";
                      }
                      if (val.length < 2) {
                        return "Email can't be less than 2 letter.";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: "Email",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        )),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    onSaved: (val) {
                      mypassword = val;
                    },
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Enter Password";
                      }
                      if (val.length > 100) {
                        return "Password can't be larger than 100 letter.";
                      }
                      if (val.length < 2) {
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
                        Text("Don't have an Account? "),
                        InkWell(
                          onTap: () {
                            // Navigator.of(context)
                            //     .pushReplacementNamed("signup");
                            context.pushReplacement("/register");
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
                      child: const Text("Sign In"),
                      onPressed: () async {
                        var user = await signIn();
                        AwesomeDialog(
                            context: context,
                            title: 'Error',
                            body: Text("Email verify has been sent."))
                          ..show();
                        // Future.delayed(Duration(seconds: 2)).then((value) {
                        //   Navigator.pop(context);
                        // });
                        if(user!=null){
                          if (user.user.emailVerified == false) {
                            sendEmail();
                          }
                        }

                        if (user != null && user.user.emailVerified) {
                          context.pushReplacement("/homepage");
                        }
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
// mohi@hotmail.com

sendEmail() async {
  // if (user!= null && !user.emailVerified) {
  User? user = FirebaseAuth.instance.currentUser!;

  await user.sendEmailVerification();
}
