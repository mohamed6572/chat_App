import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  static String collectionName = 'users';
  String id;
  String userName;
  String firsName;
  String lastName;
  String email;
  User({
    required this.id,
    required this.userName,
    required this.firsName,
    required this.lastName,
    required this.email,
  });
  User.fromJson(Map<String,dynamic> json)
      :this(id:json['id'] as String,
      userName:json['userName'] as String,
      firsName:json['firsName'] as String,
      lastName:json['lastName'] as String,
      email:json['email'] as String,
  );
  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'userName':userName,
      'firsName':firsName,
      'lastName':lastName,
      'email':email,
    };
  }

  static CollectionReference<User> withConverter(){
    return  FirebaseFirestore.instance.collection(collectionName)
      .withConverter<User>(
      fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
      toFirestore: (User, _) => User.toJson(),
   );
 }
}