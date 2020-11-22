import 'package:chat_app/src/app.dart';
import 'package:chat_app/src/screens/screen_elements.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'chat_page.dart';

class RegisterPage extends StatefulWidget {
  static final String id = "REGISTRATION_PAGE";

  @override
  State<StatefulWidget> createState() {
    return RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {
  String email;
  String password;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }

  Future<void> registerUser() async {
    try{
    FirebaseUser user  = (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    )).user;

    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(user: user,)));
    }catch(ex){
      showToast(ex.toString(),duration: Toast.LENGTH_LONG);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Up"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Hero(
              tag: "logo",
              child: Container(
                width: 100,
                child: Image.asset("assets/images/chat_logo.jpg"),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            onChanged: (value)=> email=value,
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
          CustomButton(
            callback: ()  async{
              await registerUser();
            },
            text: "Register",
          )
        ],
      ),
    );
  }
}
