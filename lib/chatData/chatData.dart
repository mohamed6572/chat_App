import 'package:chat_app/Provider/AuthProvider.dart';
import 'package:chat_app/chatData/MessageWidget.dart';
import 'package:chat_app/data/Message.dart';
import 'package:chat_app/data/fireStoreUtils.dart';
import 'package:chat_app/data/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatDetailes_Screan extends StatefulWidget {
  static const String routeName = 'chat_data';

  @override
  State<ChatDetailes_Screan> createState() => _ChatDetailes_ScreanState();
}

class _ChatDetailes_ScreanState extends State<ChatDetailes_Screan> {
  late Room room;

  String message = '';

  late AuthProvider provider;

  @override
  Widget build(BuildContext context) {
    provider =Provider.of<AuthProvider>(context);
    room = ModalRoute.of(context)!.settings.arguments as Room;
    return Container(
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/patren.png'))),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(room.name),
          ),
          body: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: StreamBuilder<QuerySnapshot<Message>>(
                      stream: Message.withConverter(room.id).orderBy('dateTime',descending: false).snapshots(),
                       builder:(context, snapshot) {
                        if(snapshot.hasError){
                          return Text(snapshot.error.toString());
                        }else if(snapshot.connectionState==ConnectionState.waiting){
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        var data = snapshot.data!.docs.map((doc) =>doc.data()).toList();
                        return ListView.builder(itemBuilder: (context, index) {
                          return MessageWidget(data[index]);
                        },

                        itemCount: data.length,);
                       }
                      ,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: TextEditingController(
                    text: message
                ),
                        onChanged: (text) {
                          message = text;
                        },
                        decoration: InputDecoration(
                            hintText: 'type ypur message',
                            focusColor: Colors.grey,
                            focusedBorder: OutlineInputBorder(
                              borderSide:

                                  BorderSide(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12)),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          sendMessage();
                        },
                        child: Row(
                          children: [
                            Text('send'),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.send),
                          ],
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  sendMessage()async{
    Message m = Message(id: '',
        content: message,
        dateTime:
        DateTime.now(), senderId: provider.user!.id, senderName: provider.user!.userName);
   var res = await addMessage(m,room.id);
    message='';
    setState(() {});

  }
}
