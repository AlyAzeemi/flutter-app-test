import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '../models/students.dart';

class StudentCreateView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StudentCreateViewState();
  }
}

class _StudentCreateViewState extends State<StudentCreateView> {
  Student _student;
  GlobalKey _formKey = GlobalKey<FormState>();

  String group = "Woman";
  String gender;

  _otherTextFieldStatus() {
    if (gender == "Other") {
      return true;
    }
    return false;
  }

  File studentFormImage;
  _openGallery() async {
    studentFormImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {});
    Navigator.of(context).pop();
  }

  _openCamera() async {
    studentFormImage = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {});
    Navigator.of(context).pop();
  }

  Future<void> _profilePicturePrompt(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Choose'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text('Gallery'),
                    onTap: () => _openGallery(),
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text('Camera'),
                    onTap: () => _openCamera(),
                  ),
                ],
              ),
            ),
          );
        });
  }

  //Opens calender to select date
  DateTime selectedDate = DateTime.now();
  TextEditingController dateString = TextEditingController();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1920),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateString.text = "${selectedDate.toLocal()}".split(" ")[0];
      });
    }
  }

  _presenceCheck(value) {
    if (value.isEmpty) {
      return "Field can not be left empty.";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student'),
        actions: <Widget>[
          //IconButton(icon: Icon(Icons.save), onPressed: (){},)
        ],
      ),
      body: Builder(
          builder: (context) => Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 1.3),
                    child: Column(
                      //mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          constraints: BoxConstraints(
                            maxHeight: 300,
                          ),
                          alignment: Alignment.bottomRight,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://i.stack.imgur.com/l60Hf.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: FloatingActionButton(
                            onPressed: () {
                              _profilePicturePrompt(context);
                            },
                            backgroundColor: Colors.blue,
                            splashColor: Colors.lightBlueAccent,
                            child: Icon(Icons.image),
                          ),
                        ),

                        //Name

                        Container(
                          width: 300,
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: "Name",
                                labelStyle: TextStyle(color: Colors.black)),
                            onSaved: (val) {},
                          ),
                        ),

                        Container(
                          width: 300,
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: "Roll Number",
                                labelStyle: TextStyle(color: Colors.black)),
                            onSaved: (val) {},
                            keyboardType: TextInputType.number,
                          ),
                        ),

                        Container(
                          width: 300,
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: "Registration Number",
                                labelStyle: TextStyle(color: Colors.black)),
                            onSaved: (val) {},
                            keyboardType: TextInputType.number,
                          ),
                        ),

                        //Datefield

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                left: 10,
                              ),
                              width: 100,
                              child: TextFormField(
                                controller: dateString,
                                decoration: InputDecoration(
                                    labelText: "Date of Birth",
                                    labelStyle: TextStyle(color: Colors.black)),
                                enabled: false,
                                onSaved: (val) {},
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.calendar_today,
                                  color: Colors.blue),
                              onPressed: () {
                                _selectDate(context);
                              },
                              alignment: Alignment.bottomCenter,
                            )
                          ],
                        ),

                        //Gender Selection

                        ListTile(
                          title: Text(
                            "Gender",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Radio(
                                value: "Woman",
                                groupValue: group,
                                onChanged: (val) {
                                  gender = val;

                                  setState(() {
                                    group = val;
                                  });
                                }),
                            Text("Woman")
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Radio(
                                value: "Man",
                                groupValue: group,
                                onChanged: (val) {
                                  gender = val;

                                  setState(() {
                                    group = val;
                                  });
                                }),
                            Text("Man")
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Radio(
                              value: "Other",
                              groupValue: group,
                              onChanged: (val) {
                                gender = val;

                                setState(() {
                                  group = val;
                                });
                              },
                            ),
                            Text("Other: "),
                            Container(
                                width: 200,
                                child: TextFormField(
                                  enabled: _otherTextFieldStatus(),
                                ))
                          ],
                        ),

                        Padding(padding: EdgeInsets.only(bottom: 10)),

                        Container(
                          width: 300,
                          padding: EdgeInsets.only(
                            left: 20,
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: "Class",
                                labelStyle: TextStyle(color: Colors.black)),
                            onSaved: (val) {},
                          ),
                        ),
                        
                        Padding(padding: EdgeInsets.only(bottom: 10)),

                        Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                                                          child: ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width * 0.9,
                          child: FlatButton(
                              onPressed: () {

                              },
                              child: Text(
                                "Submit",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.blue,
                          ),
                        ),
                            ))

                      ],
                    ),
                  ),
                ),
              )),
    );
  }
}
