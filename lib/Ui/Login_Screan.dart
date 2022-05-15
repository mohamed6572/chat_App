import 'package:chat_app/Home/Home_Screan.dart';
import 'package:chat_app/Provider/AuthProvider.dart';
import 'package:chat_app/Ui/Register_Screan.dart';
import 'package:chat_app/Utils.dart';
import 'package:chat_app/data/fireStoreUtils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login_Screan extends StatefulWidget{
  static const String routeName='signin';

  @override
  State<Login_Screan> createState() => _Login_ScreanState();
}

class _Login_ScreanState extends State<Login_Screan> {
  String email='',password='';

  var formkey = GlobalKey<FormState>();
  late AuthProvider provider;


  bool visablePassword = true;
  EmailData? emailData =null ;
  @override
  Widget build(BuildContext context) {
    provider=Provider.of<AuthProvider>(context);
    if(ModalRoute.of(context)!.settings.arguments!=null)
 emailData = ModalRoute.of(context)!.settings.arguments as EmailData;
    return Container(
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image:AssetImage(
                'assets/images/patren.png'
              ),
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Sign In'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*0.25,),
                    TextFormField(
                      initialValue: emailData?.Email??"",
                      onChanged: (text){
                        email=text;
                      },
                      validator: (text) {
                        if(text==null || text.trim().isEmpty){
                          return 'Please Enter your Email';
                        }
                        if(!IsValidEmail(email)){
                          return 'Please Enter a Vaild Email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email'
                      ),
                    ),
                    TextFormField(

                      initialValue: emailData?.Password??"",
                      onChanged: (text){
                        password=text;
                      },
                      validator: (text) {
                      if(text==null || text.trim().isEmpty){
                        return 'Please Enter Password';
                      }
                      if(text.length<6){
                        return 'password should be at least 6 chars';
                      }
                      return null;
                    },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: visablePassword
                          ?Icon(Icons.visibility_off)
                          :Icon(Icons.visibility),
                          onPressed: ()=>
                          setState(()=> visablePassword = !visablePassword ),
                        )
                      ),
                      obscureText: visablePassword,
                    ),
                    SizedBox(height: 10,),
                    ElevatedButton(
                        onPressed: (){
                          if(formkey.currentState?.validate()==true){
                            LoginwithFireBaseAuth();

                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Sign In'),
                              Icon(Icons.arrow_forward),
                            ],
                          ),
                        )
                    ),
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, Register_Screan.routeName);
                    },
                        child: Text('Or Create Account')
                    ),

                  ],

                ),
              ),
            ),
          ),

        ),
      ),
    );
  }

  void LoginwithFireBaseAuth()async{
  try{
    showloading(context);
    var result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    hideloading(context);

    if(result.user!=null){
      //showMessege('user Logged in  Successfully', context);
      //retrive user from database
     var fireStoreUser = await getUserById(result.user!.uid);
     if(fireStoreUser!=null){
       //save user in provider
       provider.updateUser(fireStoreUser);
       Navigator.pushReplacementNamed(context, Home_Screan.routeName);
     }
    }
  } catch(error){
    hideloading(context);
    showMessege('invalid Email or Password', context);



    }
  }
}