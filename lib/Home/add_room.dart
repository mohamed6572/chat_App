import 'package:chat_app/Home/CategoriesBottomSheet.dart';
import 'package:chat_app/Utils.dart';
import 'package:chat_app/data/fireStoreUtils.dart';
import 'package:chat_app/data/room.dart';
import 'package:flutter/material.dart';

class AddRoomScrean extends StatefulWidget {
  static const String routeName = 'addRoom';

  @override
  State<AddRoomScrean> createState() => _AddRoomScreanState();
}

class _AddRoomScreanState extends State<AddRoomScrean> {
  String name='';
  String description='';
  Category selectedCategory = categories[0];
  var formKey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/patren.png'))),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Add Chat App'),
          ),
          body: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 5))
              ],
            ),
            child: Form(
              key: formKey ,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Create New Room',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    'assets/images/group_logo.png',
                    height: 80,
                    fit: BoxFit.fitHeight,
                  ),
                  TextFormField(
                    onChanged: (text){
                      name=text;
                    },
                    validator: (text){
                      if(text==null || text.isEmpty){
                        return 'please enter room name';
                      }
                      return null;
                  },
                    decoration: InputDecoration(
                      labelText: 'Room Name',
                    ),
                  ),
                  TextFormField(
                    onChanged: (text){
                      description=text;
                    },
                    validator: (text){
                      if(text==null || text.isEmpty){
                        return 'please enter room description';
                      }
                      return null;
                    },
                    minLines: 4,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Description',
                    ),
                  ),
                  SizedBox(height: 8,),
                  InkWell(
                    onTap: (){
                      showCategoriesBottomSheet();

                    },
                    child: Row(
                      children: [
                        Image.asset(selectedCategory.image,height: 24,width: 24,),
                        Text(selectedCategory.name),

                      ],
                    ),
                  ),
                  ElevatedButton(

                      onPressed: (){
                        createRoom();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text('Create'),
                      ))

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showCategoriesBottomSheet(){
    showModalBottomSheet(context: context, builder: (buildContext){
      return CategoriesBottomSheet(onCategorySelected);
    });
  }
  void onCategorySelected(Category category){
    this.selectedCategory=category;
    setState(() {});

  }

  void CreateRoom(){

  }
  void createRoom()async{
    if(formKey.currentState!.validate()){
      try {
        showloading(context);
            var res =await  addRoomToFireStore(Room(id: '', name: name, description: description, categoryId: selectedCategory.id));
            hideloading(context);
            Navigator.pop(context);
      } on Exception catch (e) {
        showMessege(e.toString(),context);
      }
    }
  }
}
