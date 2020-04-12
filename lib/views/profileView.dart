import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//Centralised Profile view


class ProfileView extends StatelessWidget{
  String cnic;  //Or any unique identifier for the record that was clicked on
  ProfileView(this.cnic);

  Future<Map> _getProfile(){
    //if(){}
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Profile"),),
      body: LayoutBuilder(
        builder: (context,viewportConstraints)=>SingleChildScrollView(
          child: Column(
            children: <Widget>[
              
            ],
          ),
        ),
      ),
    );
  }
}