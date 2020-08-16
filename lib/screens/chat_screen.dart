import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  void _addMessage() {
    Firestore.instance
        .collection('chats/rzfzOWmAkme2DwlJzrpD/messages/')
        .add(<String, dynamic>{
      'text': 'This is added by application!',
      'created_at': FieldValue.serverTimestamp()
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('chats/rzfzOWmAkme2DwlJzrpD/messages/')
            .orderBy('created_at')
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final documents = streamSnapshot.data.documents;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (ctx, index) => Container(
              padding: EdgeInsets.all(8),
              child: Text(documents[index]['text']),
            ),
          );
        },
      ),
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add), onPressed: _addMessage),
    );
  }
}
