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
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> certifications = [
    "Highschool Diploma",
    "A-levels",
    "Undergrad",
    "Bachelors",
    "Masters",
    "PhD"
  ];
  String group = "Woman";

  //Proxy Teacher Class values
  String fullName;
  String doB;
  String cnic;
  String gender = "Woman";
  List<Map> education = [
    {
      "certification": "PhD",
      "subject": "Subpar Design",
      "institution": "Word Wibe Web",
      "yearGraduated": "DD/MM/YYYY"
    },
  ];

  _otherTextFieldStatus() {
    if (gender == "Other") {
      return true;
    }
    return false;
  }

  File teacherFormImage;
  String imgUrl = "https://i.stack.imgur.com/l60Hf.png";
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

  _uploadImageToServer() async {
    //ImageUploadFunctionGoesHere
    String imgUrl = "TheRetrievedImageURLGoesHere";
    return true;
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
                    onTap: () {
                      _openGallery();
                      _uploadImageToServer();
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text('Camera'),
                    onTap: () {
                      _openCamera();
                      _uploadImageToServer();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  //Opens calender to select date
  DateTime selectedDate = DateTime.now();
  TextEditingController birthDateString = TextEditingController();
  TextEditingController graduationDateString = TextEditingController();
  Future<Null> _selectDate(BuildContext context, bool flag) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1920),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        if (flag) {
          birthDateString.text = "${selectedDate.toLocal()}".split(" ")[0];
        } else {
          graduationDateString.text = "${selectedDate.toLocal()}".split(" ")[0];
        }
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

  TextEditingController dropDownSelected = TextEditingController();
  _educationPrompt(BuildContext context) {
    final _eduFormKey = GlobalKey<FormState>();
    print(dropDownSelected.text.length);
    if (dropDownSelected.text.length == 0) {
      dropDownSelected.text = certifications[0];
    }
    print(dropDownSelected.text);
    Map history=Map();

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setStateInside) => Form(
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
                            setStateInside(() {
                              dropDownSelected =
                                  TextEditingController(text: "${val}");
                              print(dropDownSelected);
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                          width: 100,
                          child: TextFormField(
                            controller: graduationDateString,
                            decoration: InputDecoration(
                                labelText: "Graduated",
                                labelStyle: TextStyle(color: Colors.black)),
                            enabled: false,
                            onSaved: (val) {
                              history["yearGraduated"] = val;
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.calendar_today, color: Colors.blue),
                          onPressed: () {
                            _selectDate(context, false);
                          },
                          alignment: Alignment.bottomCenter,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        child: Text("Save"),
                        onPressed: () {
                          if (_eduFormKey.currentState.validate()) {
                            _eduFormKey.currentState.save();
                            setState(() {
                              education.add(history);
                              Navigator.pop(context);
                            });
                          }
                        },
                      ),
                    )
                  ],
                )),
          ));
        });
  }

  _educationDisplay(BuildContext context) {
    if (education.length == 0) {
      return Container(
        child: Center(
          child: Text("Tap the + icon to add certifications"),
        ),
      );
    }
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height * 0.3),
      child: ListView.builder(
        itemCount: education.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
                "${education[index]["certification"]} in ${education[index]["subject"]}"),
            subtitle: Text("Institute: ${education[index]["institution"]}\n" +
                "Graduated: ${education[index]["yearGraduated"]}"),
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

  _sendToServer(Teacher teacher) {
    //Send HTTP POST REQ TO SERVER
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
                              image: NetworkImage(imgUrl),
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
                            onSaved: (val) {
                              fullName = val;
                            },
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
                            onSaved: (val) {
                              cnic = val;
                            },
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
                                controller: birthDateString,
                                decoration: InputDecoration(
                                    labelText: "Date of Birth",
                                    labelStyle: TextStyle(color: Colors.black)),
                                enabled: false,
                                onSaved: (val) {
                                  doB = val;
                                },
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.calendar_today,
                                  color: Colors.blue),
                              onPressed: () {
                                _selectDate(context, true);
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
                            onPressed: () {
                              if (_formKey.currentState.validate() &&
                                  education.length > 0) {
                                _formKey.currentState.save();

                                String _certification =
                                    education[education.length - 1]
                                        ["certification"];
                                String _subject =
                                    education[education.length - 1]["subject"];
                                String _institution =
                                    education[education.length - 1]
                                        ["education"];

                                String lastDegree =
                                    "${_certification} in ${_subject} from ${_institution}";
                                Teacher _teacher = Teacher.extended(
                                    fullName,
                                    imgUrl,
                                    gender,
                                    doB,
                                    education,
                                    lastDegree,
                                    cnic);

                                _sendToServer(_teacher);
                              }
                            },
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
