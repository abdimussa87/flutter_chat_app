import 'package:chat_app/src/screens/screen_elements.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  static final String id = "CHAT_PAGE";
  final FirebaseUser user;

  const ChatPage({Key key, this.user}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  // a callback for the sendMessage Button 
  // all it does is go to firestore and add the text and the username by using the map literal
  Future<void> sendMessage() async {
    if (messageController.text.length > 0) {
      await _firestore
          .collection("messages")
          .add({"text": messageController.text, "from": widget.user.email,'date':DateTime.now().toIso8601String()});
    }

    messageController.clear();
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        curve: Curves.easeOut, duration: Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Up"),
        leading: Hero(
          tag: "logo",
          child: Container(
            height: 40,
            child: Image.asset("assets/images/chat_logo.jpg"),
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.of(context).popUntil((route) => route.isFirst);
              }),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                stream: _firestore.collection("messages").orderBy('date').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    List<DocumentSnapshot> docs = snapshot.data.documents;
                    List<Widget> messages = docs.map((doc)=> Message(
                      from: doc.data['from'],
                      text: doc.data['text'],
                      me: widget.user.email== doc.data['from'],
                    )).toList();
                    return ListView(
                      controller: scrollController,
                      children: <Widget>[
                        ...messages
                      ],
                    );
                  }
                },
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    onSubmitted: (value)=>sendMessage(),
                    controller: messageController,
                  ),
                ),
                SendButton(
                  text: "Send",
                  callback: sendMessage,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
