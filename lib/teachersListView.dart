import 'package:flutter/material.dart';
import 'dart:async';
import "dart:convert";
import 'package:http/http.dart' as http;

class TeacherViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TeacherViewPageState();
  }
}

class _TeacherViewPageState extends State<TeacherViewPage> {
  Future<List<Teacher>> _getTeachers() async {
    //var data = await http.get(url)
    var data =
        '''[{"fullName":"Teacher A", "imgUrl":"https://i.stack.imgur.com/l60Hf.png", "doB":"DD/MM/YY", "education":"Insert educational background here.", "lastDegree":"LastCertificationGoesHere", "CNIC":"1234567890123"},{"fullName":"Teacher B", "imgUrl":"https://i.stack.imgur.com/l60Hf.png", "doB":"DD/MM/YY", "education":"Insert educational background here.", "lastDegree":"LastCertificationGoesHere", "CNIC":"1234567890123"}]''';
    var jsonData = jsonDecode(data);

    List<Teacher> teacherList = [];

    for (var t in jsonData) {
      Teacher teacher = Teacher(t["fullName"], t["imgUrl"], t["doB"],
          t["education"], t["lastDegree"], t["CNIC"]);
      teacherList.add(teacher);
    }
    print(teacherList);
    return teacherList;
  }

  Icon actionIcon = Icon(Icons.search);
  Widget appBarTitle = Text("Teachers");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        actions: <Widget>[
          IconButton(
            icon: actionIcon, 
            onPressed: () {
              setState(() {
                if(this.actionIcon.icon == Icons.search){
                  this.actionIcon = Icon(Icons.close);
                  this.appBarTitle = TextField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search,color: Colors.white,),
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.white)
                    ),
                  );
                }else{
                  this.actionIcon = Icon(Icons.search);
                  this.appBarTitle = Text("Teachers");
                }
              });
            }
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
            height: MediaQuery.of(context).size.height * 0.7,
            child: FutureBuilder(
              future: _getTeachers(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print(snapshot.data);
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Text("Loading..."),
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(snapshot.data[index].imgUrl),
                          ),
                          title: Text(snapshot.data[index].fullName),
                          subtitle: Text(
                            "Degree:" +
                                snapshot.data[index].lastDegree +
                                "\n" +
                                "DoB:" +
                                snapshot.data[index].doB +
                                "\n" +
                                "CNIC:" +
                                snapshot.data[index].cnic,
                          ),
                          onTap:
                              () {}, //Supposed to take to profile page probably
                        );
                      });
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/teachers/create');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Teacher {
  final String fullName;
  final String doB;
  final String education;
  final String lastDegree;
  final String cnic;
  final String imgUrl;

  Teacher(this.fullName, this.imgUrl, this.doB, this.education, this.lastDegree,
      this.cnic);
}


