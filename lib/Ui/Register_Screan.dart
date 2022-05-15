import 'package:chat_app/Home/Home_Screan.dart';
import 'package:chat_app/Provider/AuthProvider.dart';
import 'package:chat_app/Ui/Login_Screan.dart';
import 'package:chat_app/Utils.dart';
import 'package:chat_app/data/fireStoreUtils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/data/user.dart' as AppUser;
import 'package:provider/provider.dart';

class Register_Screan extends StatefulWidget{
  static const String routeName='signUp';

  @override
  State<Register_Screan> createState() => _Register_ScreanState();
}



class _Register_ScreanState extends State<Register_Screan> {
   String firstName= '',lastName= '',username='',email='',password='';

  var formkey = GlobalKey<FormState>();

bool visablePassword = true;
late AuthProvider provider;


   @override
  Widget build(BuildContext context) {
     provider = Provider.of<AuthProvider>(context);

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
            title: Text('Create Account'),
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
                      onChanged: (text){
                        firstName=text;
                      },
                      validator: (text) {
                        if(text==null || text.trim().isEmpty){
                          return 'Please Enter The First Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'First Name'
                      ),
                    ),
                    TextFormField(
                      onChanged: (text){
                        lastName=text;
                      },
                      validator: (text) {
                        if(text==null || text.trim().isEmpty){
                          return 'Please Enter The Last Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Last Name'
                      ),
                    ),
                    TextFormField(
                      onChanged: (text){
                        username=text;
                      },
                      validator: (text) {
                        if(text==null || text.trim().isEmpty){
                          return 'Please Enter The  UserName';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'UserName'
                      ),
                    ),
                    TextFormField(
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
                            createAccountwithFireBaseAuth();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Create Account'),
                              Icon(Icons.arrow_forward),
                            ],
                          ),
                        )
                    )

                  ],

                ),
              ),
            ),
          ),

        ),
      ),
    );
  }

  void createAccountwithFireBaseAuth()async{
    try{
    showloading(context);
    var result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    hideloading(context);
    if(result.user!=null){
      var myUser = AppUser.User(id: result.user!.uid,
          userName: username ,
          firsName: firstName ,
          lastName: lastName,
          email: email
      );
    adduserToFireStore(myUser).then((value)  {
      provider.updateUser(myUser);

      showMessege('user registered Successfully', context);
      //todo: add user to provider
      Navigator.pushReplacementNamed(context, Home_Screan.routeName);

    }).onError((error, stackTrace) {
    showMessege(error.toString(), context);

    });

      // showMessege('user registered Successfully', context);
      Navigator.pushReplacementNamed(context, Login_Screan.routeName,arguments: EmailData(email, password));



    }
  } catch(error){
    hideloading(context);
    showMessege(error.toString(), context);


    }
  }
}

class EmailData{
  String Email='';
  String Password='';
  EmailData(this.Email,this.Password);

}