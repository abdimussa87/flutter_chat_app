import 'package:chat_app/src/screens/login_page.dart';
import 'package:chat_app/src/screens/register_page.dart';
import 'package:flutter/material.dart';
import 'screen_elements.dart';
class HomePage extends StatelessWidget {
  static final  String id = "HOME_PAGE";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 100,
                child: Hero(
                  tag: "logo",
                  child: Image.asset("assets/images/chat_logo.jpg"),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "Chat Up",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 40,
                ),
              ),
            ],
          ),
         SizedBox(height: 60,),
          CustomButton(
            text: "Login",
            callback: () {
              Navigator.pushNamed(context, LoginPage.id);
            },
          ),
           CustomButton(
            text: "Register",
            callback: () {
              Navigator.pushNamed(context, RegisterPage.id);
            },
          ),
        ],
      ),
    );
  }
}

