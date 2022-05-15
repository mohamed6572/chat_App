// @dart=2.9

import 'package:chat_app/Home/add_room.dart';
import 'package:chat_app/MyThemeData.dart';
import 'package:chat_app/Provider/AuthProvider.dart';
import 'package:chat_app/Ui/Login_Screan.dart';
import 'package:chat_app/chatData/chatData.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Home/Home_Screan.dart';
import 'Ui/Register_Screan.dart';
import 'package:provider/provider.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider<AuthProvider>(
      create: (buildContext)=>AuthProvider(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat_App',
      theme: MyThemeData.theme,
      routes: {
        Register_Screan.routeName: (context)=> Register_Screan(),
        Login_Screan.routeName : (context)=> Login_Screan(),
        Home_Screan.routeName : (context)=>Home_Screan(),
        AddRoomScrean.routeName : (context)=>AddRoomScrean(),
        ChatDetailes_Screan.routeName : (context)=>ChatDetailes_Screan(),
      },

      initialRoute: provider.IsLogedIn()?
      Home_Screan.routeName
      :Login_Screan.routeName,
    );
  }
}
