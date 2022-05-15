import 'package:chat_app/Home/RoomGrideView.dart';
import 'package:chat_app/Home/add_room.dart';
import 'package:chat_app/data/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home_Screan extends StatelessWidget {
  static const String routeName = 'Home';
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/patren.png'),
                fit: BoxFit.cover)),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Chat App'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context,AddRoomScrean.routeName);
            },
            child: Icon(Icons.add),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: StreamBuilder<QuerySnapshot<Room>>(
              stream: Room.withConverter().snapshots(),
              builder:(builder,snapshot){
                if(snapshot.hasError){
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }else if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
               var roomsList= snapshot.data?.docs.map((e) => e.data()).toList();
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: .9
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return RoomGrideView(roomsList!.elementAt(index));
                  },
                  itemCount: roomsList?.length?? 0,

                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
