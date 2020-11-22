import 'package:chat_app/src/screens/home_page.dart';
import 'package:chat_app/src/screens/register_page.dart';
import 'package:flutter/material.dart';

import '../src/screens/login_page.dart';
import '../src/screens/chat_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chat App",
      theme: ThemeData.dark(),
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (context) => HomePage(),
        RegisterPage.id: (context) => RegisterPage(),
        LoginPage.id: (context) => LoginPage(),
        ChatPage.id: (context) => ChatPage()
      },
    );
  }
}
