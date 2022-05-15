import 'package:chat_app/data/Message.dart';
import 'package:chat_app/data/room.dart';
import 'package:chat_app/data/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> adduserToFireStore(User user){
  return  User.withConverter()
       .doc(user.id)
       .set(user);
}
Future<void> addRoomToFireStore(Room room) {
  var docRef = Room.withConverter().doc();
  room.id = docRef.id;
  return docRef.set(room);
}

Future<User?> getUserById(String id)async{
  DocumentSnapshot<User> result =
      await User.withConverter().doc(id).get();
   return result.data();
}

Future<void> addMessage(Message message ,String roomId){
 var docRef = Message.withConverter(roomId).doc();
  message.id = docRef.id;
 return docRef.set(message);
}