import 'package:chat_app/Utils.dart';
import 'package:chat_app/chatData/chatData.dart';
import 'package:chat_app/data/room.dart';
import 'package:flutter/material.dart';

class RoomGrideView extends StatelessWidget{
  Room room;
  RoomGrideView(this.room);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, ChatDetailes_Screan.routeName,arguments: room);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 5))
          ],
        ),
        child: Column(
          children: [
            Image.asset(Category.fromId(room.categoryId).image,

            ),
            SizedBox(height: 4,),
            Text(room.name,maxLines: 1,

            ),
          ],
        ),
      ),
    );
  }
}
