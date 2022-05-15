import 'package:chat_app/Provider/AuthProvider.dart';
import 'package:chat_app/data/Message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {
  Message message;
  MessageWidget(this.message);
  late AuthProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AuthProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
        child: message.senderId == provider.user!.id
            ? SendMessage(message.content, message.dateTime.toString())
            : RecievedMessage(message.content, message.dateTime.toString(),
                message.senderName));
  }
}

class SendMessage extends StatelessWidget {
  String content;
  String time;
  SendMessage(this.content, this.time);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(child: Text(time,textAlign: TextAlign.right,)),
        Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(0),
              topRight:  Radius.circular(24),
              bottomLeft:  Radius.circular(24),
              topLeft:  Radius.circular(24),
            )
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(content,
           textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.white
            ),
            ),
          ),
        ),
      ],
    );
  }
}

class RecievedMessage extends StatelessWidget {
  String content;
  String time;
  String senderName;
  RecievedMessage(this.content, this.time, this.senderName);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(senderName),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(24),
                    topRight:  Radius.circular(24),
                    bottomLeft:  Radius.circular(0),
                    topLeft:  Radius.circular(24),
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(content,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Colors.grey
                  ),
                ),
              ),
            ),
            Expanded(child: Text(time,textAlign: TextAlign.left,)),

          ],
        ),
      ],
    );
  }
}
