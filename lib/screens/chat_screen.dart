import 'package:flutter/material.dart';
import 'package:igloo/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:igloo/screens/welcome_screen.dart';

/// chat_screen.dart:
///   A simple live chat screen that can be implemented
///   as a club-specific memeber group chat in later revisions.

// Declare a Firestore.instance & FirebaseUser
// as global variables.
final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

// Create a navagation id for the Chat Screen.
// Create the state for the StatefulWidget.
class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

// Main function of the ChatScreen Stateful Widget
class _ChatScreenState extends State<ChatScreen> {

  // Instantiate a TextEditingController to clear text input
  // after message is sent by the end user.
  final messageTextController = TextEditingController();

  // Store the FirebaseAuth instance in an _auth variable.
  final _auth = FirebaseAuth.instance;

  // Stores the user's message.
  String messageText;

  // Initalizes the page's state.
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  // Will get the user's data and store it in the loggedInUser variable.
  void getCurrentUser() async {
    // Try pulling the logged in user's data.
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email); // Print statement for debugging.
      }
    }
     // Find a way to handle an exception if a user accesses this page.
     // w/o being logged in, not likely but still find a way to handle.
    catch (e) {
      print(e);
    }
  }

  // Build the main chat window widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null, // Do not display a widget before App Bar title.
        actions: <Widget>[
          IconButton( // Acts as a way to sign out from app, should be changed to another function.
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                _auth.signOut();
                Navigator.popAndPushNamed(context, WelcomeScreen.id);
              }),
        ],
        // Once integration into each club's page is implemented, have it display
        // "<The name of the Club> Group Chat" as the title.
        title: Text('Club Group Chat'), 
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(), // Call creates a stream of messages as the Column's first member.
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    // TextField where user enters a message.
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  // Send button. Clears textfield above, adds message to 
                  // 'messages' collection on firestore.
                  FlatButton(
                    onPressed: () {
                      messageTextController.clear();
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': loggedInUser.email,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Creates a Stream of Previous and current messages to the chat window.
class MessagesStream extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      // Build a chat window of message bubbles.
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        // Pull message history from firestore snapshot.
        final messages = snapshot.data.documents.reversed;
        // Initalize an empty collecton of messageBubbles.
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message.data['text'];
          final messageSender = message.data['sender'];
          final currentUser = loggedInUser.email;
          final messageBubble = MessageBubble(
            sender: messageSender, 
            text: messageText,
            isUser: currentUser == messageSender,
          );
          // Add messages to messageBubbles Widget.
          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 10.0, 
            ),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  
  MessageBubble({this.sender, this.text, this.isUser});
  final String sender; // Stores the sender data (Displays email now, change to Display Name Field)
  final String text;   // Store the contents of the message.
  final bool isUser;   // Boolean to determine if message is from the loggedInUser.

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        // Ternary operator to align message bubble based on who sent it.
        crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text( // Display sender data above message bubble (Change from email to display name)
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
            ),
          Material(
            // Message borders are reversed in shape due to user-specific screen alignment
            borderRadius: isUser 
              ? BorderRadius.only(
                topLeft: Radius.circular(30.0), 
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0)) 
              : BorderRadius.only(
                topRight: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0)),
            elevation: 5.0,
            // Color LoggedIn user messages a lighter shade of blue.
            color: isUser ? Colors.lightBlueAccent : Colors.blue,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0, 
                horizontal: 20.0,
                ),
              child: Text(
                '$text', // Put text data in message bubble.
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  } 
}