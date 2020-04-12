import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '../models/teachers.dart';

class TeacherCreateView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TeacherCreateViewState();
  }
}

class _TeacherCreateViewState extends State<TeacherCreateView> {
  Teacher _teacher;
  GlobalKey _formKey = GlobalKey<FormState>();
  List<String> certifications = [
    "Highschool Diploma",
    "A-levels",
    "Undergrad",
    "Bachelors",
    "Masters",
    "PhD"
  ];
  String group = "Female";
  String gender;

  bool addDegree = false;
  List<Map> education = [
    {
      "certification": "PhD",
      "subject": "Subpar Design",
      "institution": "Word Wibe Web",
      "dateOfGraduation": "DD/MM/YYYY"
    },
    {
      "certification": "PhD",
      "subject": "Subpar Design",
      "institution": "Word Wibe Web",
      "dateOfGraduation": "DD/MM/YYYY"
    },
    {
      "certification": "PhD",
      "subject": "Subpar Design",
      "institution": "Word Wibe Web",
      "dateOfGraduation": "DD/MM/YYYY"
    }
  ];

  _otherTextFieldStatus() {
    if (gender == "Other") {
      return true;
    }
    return false;
  }

  File teacherFormImage;
  _openGallery() async {
    teacherFormImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {});
    Navigator.of(context).pop();
  }

  _openCamera() async {
    teacherFormImage = await ImagePicker.pickImage(source: ImageSource.camera);
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

  _educationPrompt(BuildContext context) {
    final _eduFormKey = GlobalKey<FormState>();
    TextEditingController dropDownSelected = TextEditingController();
    dropDownSelected.text = certifications[0];
    Map history;

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: Form(
                  key: _eduFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration:
                              InputDecoration(labelText: "Institution Name"),
                          validator: (val) {
                            return _presenceCheck(val);
                          },
                          onSaved: (val) {
                            history["instution"] = val;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: DropdownButtonFormField(
                            decoration:
                                InputDecoration(labelText: "Certification"),
                            value: dropDownSelected.text,
                            icon: Icon(Icons.arrow_downward),
                            autovalidate: true,
                            hint: Text("Certification"),
                            items:
                                certifications.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                dropDownSelected.text = val;
                              });
                            },
                            onSaved: (val) {
                              print(val);
                              history["certification"] = val;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(labelText: "Subject"),
                          validator: (val) {
                            return _presenceCheck(val);
                          },
                          onSaved: (val) {
                            history["subject"] = val;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          child: Text("Save"),
                          onPressed: () {
                            if (_eduFormKey.currentState.validate()) {
                              _eduFormKey.currentState.save();
                              print(history);
                            }
                          },
                        ),
                      )
                    ],
                  )));
        });
  }

  _educationDisplay(BuildContext context) {
    print(this.education);
    if (education.length == 0) {
      return Container(
        child: Center(
          child: Text("Tap the + icon to add certifications"),
        ),
      );
    }
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width, maxHeight: MediaQuery.of(context).size.height*0.3),
      child: ListView.builder(
        itemCount: education.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
                "${education[index]["certification"]} in ${education[index]["subject"]}"),
            subtitle: Text("Institute: ${education[index]["institution"]}\n" +
                "Graduated: ${education[index]["dateOfGraduation"]}"),
            trailing: CircleAvatar(
              backgroundColor: Colors.red,
              child: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                onPressed: () {
                  education.remove(education[index]);
                  setState(() {});
                },
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Teacher'),
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
                        maxHeight: MediaQuery.of(context).size.height * 1.5),
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
                                labelText: "CNIC",
                                labelStyle: TextStyle(color: Colors.black)),
                            onSaved: (val) {},
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
                                value: "Female",
                                groupValue: group,
                                onChanged: (val) {
                                  gender = val;

                                  setState(() {
                                    group = val;
                                  });
                                }),
                            Text("Female")
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Radio(
                                value: "Male",
                                groupValue: group,
                                onChanged: (val) {
                                  gender = val;

                                  setState(() {
                                    group = val;
                                  });
                                }),
                            Text("Male")
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

                        ListTile(
                          title: Text(
                            "Education",
                            style: TextStyle(fontSize: 18),
                          ),
                          trailing: IconButton(
                            alignment: Alignment.centerRight,
                              icon: Icon(
                                Icons.add,
                                color: Colors.blue,
                                size: 35,
                              ),
                              onPressed: () {
                                _educationPrompt(context);
                              }),
                        ),
                        _educationDisplay(context),
                        Center(
                            child: ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width * 0.9,
                          child: FlatButton(
                            onPressed: () {},
                            child: Text(
                              "Submit",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.blue,
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
