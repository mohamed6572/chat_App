import 'package:chat_app/data/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  static const String collectionName='message';
  String id;
  String content;
  DateTime dateTime;
  String senderId;
  String senderName;
  Message({required this.id,required this.content,required this.dateTime,required this.senderId,required this.senderName});
  Message.fromJson(Map<String,dynamic> json)
  :this(
    id:json['id'] as String,
    content:json['content'] as String,
    dateTime:  DateTime.fromMillisecondsSinceEpoch((json['dateTime'] as int)),
    senderId:json['senderId'] as String,
    senderName:json['senderName'] as String,
  );

  Map<String,dynamic> toJson(){
    return {
      'id' :id,
      'content':content,
      'dateTime':dateTime.millisecondsSinceEpoch,
      'senderId':senderId,
      'senderName':senderName

    };
  }
  
 static CollectionReference<Message> withConverter(String roomId){

  return Room.withConverter()
       .doc(roomId).collection(Message.collectionName)
       .withConverter<Message>(fromFirestore: (snapShot,_){
     return Message.fromJson(snapShot.data()!);
   }, toFirestore: (Message message,_) =>message.toJson());

      }
}