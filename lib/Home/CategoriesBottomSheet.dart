import 'package:chat_app/Utils.dart';
import 'package:flutter/material.dart';

class CategoriesBottomSheet extends StatelessWidget{
Function onCategoriescallBack;
CategoriesBottomSheet(this.onCategoriescallBack);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (buildContext,index){
      return InkWell(
        onTap: (){
          onCategoriescallBack(categories[index]);
          Navigator.pop(buildContext);
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Image.asset(categories[index].image,height: 24,width: 24,),
              Text(categories[index].name),
            ],
          ),
        ),
      );
    },
    itemCount: categories.length,
    );
  }
}
