import 'package:chat_app/data/fireStoreUtils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' ;
import 'package:chat_app/data/user.dart' as AppUser;

class AuthProvider extends ChangeNotifier{
  AppUser.User? user =null;
  AuthProvider(){
    FetchFireStoreUser();
  }
  void updateUser(AppUser.User user){
    this.user = user;
    notifyListeners();
  }

  void FetchFireStoreUser()async{
    if(FirebaseAuth.instance.currentUser!=null){
    var firestoreuser = await getUserById(FirebaseAuth.instance.currentUser!.uid);
    user = firestoreuser;

  }
}

  bool IsLogedIn(){
    return FirebaseAuth.instance.currentUser!=null;
  }

}