import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:layout/models/students.dart';
import 'package:layout/models/teachers.dart';
import 'dart:convert';

//Centralised Profile view

class ProfileView extends StatelessWidget {
  String uniqueID; //Or any unique identifier for the record that was clicked on
  ProfileView(this.uniqueID);
  dynamic model;

  Future<Map> _getProfile() async {
    //Make http req using uniqueID
    //Commment one out to test for each type of reponse
    String education ='''[{"certification": "PhD","subject": "Subpar Design","institution": "Word Wibe Web","yearGraduated": "DD/MM/YYYY"},{"certification": "PhD 2","subject": "Subpar Design 2","institution": "Word Wibe Web 2","yearGraduated": "DD/MM/YYYY"}]''';
    String response ='''{"fullName":"Student A", "imgUrl":"https://i.stack.imgur.com/l60Hf.png", "gender":"Male", "doB":"DD/MM/YY", "registrationNumber":"1234567890123","rollNumber":"1234567890123","class":"ClassNameHere"}''';
    //String response ='''{"fullName":"Teacher A", "imgUrl":"https://i.stack.imgur.com/l60Hf.png", "gender":"Male", "doB":"DD/MM/YY", "education":"$education", "CNIC":"1234567890123"}''';
    Map jsonData = jsonDecode(response);
    
    return jsonData;
  }

  _createmodel(jsonData) {
    if (jsonData["education"] != null) {
      dynamic temp = jsonData["education"];
      assert(temp is List<Map>);
      print(temp);
      model = Teacher(
          jsonData["fullName"],
          jsonData["imgUrl"],
          jsonData["gender"],
          jsonData["doB"],
          temp,
          jsonData["CNIC"]);
    } else {
      model = Student(
          jsonData["fullName"],
          jsonData["imgUrl"],
          jsonData["gender"],
          jsonData["doB"],
          jsonData["registrationNumber"],
          jsonData["rollNumber"],
          jsonData["class"]);
    }

    
    return model;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: LayoutBuilder(
        builder: (context, viewportConstraints) => SingleChildScrollView(
          child: FutureBuilder(
              future: _getProfile(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Text("Loading..."),
                    ),
                  );
                } else {
                  dynamic view;
                  _createmodel(snapshot.data);

                  if (model is Teacher) {
                    view = Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                children: <Widget>[
                                  Text("CNIC: ", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                  Text("${model.cnic}", style: TextStyle(fontSize: 18,),)
                                ],
                              ),
                            ),
                          Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                children: <Widget>[
                                  Text("Education: ", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                  ListView.builder(
                                    itemCount: model.education.length,
                                    itemBuilder: (BuildContext context,int index){
                                      print(model.education.length);
                                      DateTime now = DateTime.now();
                                      return ListTile(
                                        title: Text("${model.education[index]["certification"]} in ${model.education[index]["subject"]}"),
                                        subtitle: Text(
                                          "Institution: ${model.education[index]["institution"]}\n"+
                                          "Graduated:  ${model.education[index]["yearGraduated"]}"
                                          ),
                                      );
                                    }
                                    )
                                ],
                              ),
                            ),
                        ],
                      ),
                    );
                  } else if (model is Student) {
                    view = Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                children: <Widget>[
                                  Text("Registration Number: ", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                  Text("${model.registrationNumber}", style: TextStyle(fontSize: 18,),)
                                ],
                              ),
                            ),
                          Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                children: <Widget>[
                                  Text("Roll Number: ", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                  Text("${model.rollNumber}", style: TextStyle(fontSize: 18,),)
                                ],
                              ),
                            ),
                          Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                children: <Widget>[
                                  Text("Class: ", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                  Text("${model.class_}", style: TextStyle(fontSize: 18,),)
                                ],
                              ),
                            ),
                        ],
                      ),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.33,
                            maxWidth: MediaQuery.of(context).size.width),
                        child: Image(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          image: NetworkImage(model.imgUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        model.fullName,
                        style: TextStyle(fontSize: 48),
                      ),
                      Text(
                        "CalculatedAge, ${model.doB}",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(top: 20)),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                children: <Widget>[
                                  Text("Gender: ", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                  Text("${model.gender}", style: TextStyle(fontSize: 18,),)
                                ],
                              ),
                            ),
                            view
                          ],
                        ),
                      )
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }
}
