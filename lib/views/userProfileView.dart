import "package:flutter/material.dart";
import "dart:convert";
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserProfileView extends StatefulWidget{
  @override
  UserProfileViewState createState()=>UserProfileViewState();
}
  

class UserProfileViewState extends State<UserProfileView>{
  var userData;
  File imageFile;
  UserProfileViewState(){
    var jsonString = '''{"fullName":"John Doe", "pImgUrl":"https://i.stack.imgur.com/l60Hf.png","gender":"M", "age":20, "designation":"InsertPositionHere"}''';
    this.userData = jsonDecode(jsonString);
  }

  _fieldHeading(heading){
    return Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(bottom: 1,),
                child: Text(
                  heading, 
                  style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20, 
                  fontWeight: FontWeight.bold,
                  ),
                ),
              );
  }

  _fieldInformation(info){
      return Container(
                padding: EdgeInsets.only(bottom: 2,),
                alignment: Alignment.topLeft,
                child: Text(
                  info.toString(), 
                  style: TextStyle(
                  color: Colors.black,
                  fontSize: 18, 
                  ),
                ),
              );
    }

  _openGallery()async{
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState((){});
    Navigator.of(context).pop();
  }
  _openCamera()async{
    imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState((){});
    Navigator.of(context).pop();
  }

  Future<void> _profilePicturePrompt(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text('Choose'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text('Gallery'),
                onTap: ()=>_openGallery(),
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              GestureDetector(
                child: Text('Camera'),
                onTap: ()=>_openCamera(),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            constraints: BoxConstraints(
              maxHeight: 300,
            ),
            alignment: Alignment.bottomRight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(this.userData['pImgUrl']),
                fit: BoxFit.cover,
              ),
            ),
            child: FloatingActionButton(
              onPressed: (){_profilePicturePrompt(context);},
              backgroundColor: Colors.blue,
              splashColor: Colors.lightBlueAccent,
              child: Icon(Icons.image),
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 10,),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _fieldHeading("Name"),
                _fieldInformation(this.userData['fullName']),
                _fieldHeading("Age"),
                _fieldInformation(this.userData['age']),
                _fieldHeading("Gender"),
                _fieldInformation(this.userData['gender']),
                _fieldHeading("Designation"),
                _fieldInformation(this.userData['designation']),
              ],
            ),
          )
        ],
      ),
    );

    
  }
}