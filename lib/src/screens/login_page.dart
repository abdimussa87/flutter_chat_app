import 'package:chat_app/src/screens/chat_page.dart';
import 'package:chat_app/src/screens/screen_elements.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  static final String id = "LOGIN_PAGE";
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email;
  String password;

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }

  Future<void> loginUser() async {
    try {
      FirebaseUser user = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ChatPage(user: user)));
    } catch (ex) {
      showToast(
        ex.toString(),
        duration: Toast.LENGTH_LONG,
        
        
      );
      print(ex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Chat Up"),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  width: 100,
                  child: Hero(
                    tag: "logo",
                    child: Image.asset("assets/images/chat_logo.jpg"),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                onChanged: (value) => email = value,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Enter your Email",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              TextField(
                onChanged: (value) => password = value,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter your Password",
                  border: OutlineInputBorder(),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              CustomButton(
                text: "Login",
                callback: () async {
                  await loginUser();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
