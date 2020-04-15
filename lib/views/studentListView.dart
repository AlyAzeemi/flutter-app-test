import 'package:flutter/material.dart';
import 'dart:async';
import "dart:convert";
import 'package:http/http.dart' as http;
import '../models/students.dart';

class StudentListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StudentListViewState();
  }
}

class _StudentListViewState extends State<StudentListView> {
  Future<List<Student>> _getStudents() async {
    //var data = await http.get(url)
    var data ='''[{"fullName":"Student A", "imgUrl":"https://i.stack.imgur.com/l60Hf.png", "gender":"Male", "doB":"DD/MM/YY", "registrationNumber":"1234567890123","rollNumber":"1234567890123","class":"ClassNameHere"},{"fullName":"Student B", "imgUrl":"https://i.stack.imgur.com/l60Hf.png", "gender":"Male", "doB":"DD/MM/YY", "registrationNumber":"1234567890123","rollNumber":"1234567890123","class":"ClassNameHere"}]''';
    var jsonData = jsonDecode(data);
    
    List<Student> studentList = [];

    for (var t in jsonData) {
      Student student = Student(t["fullName"], t["imgUrl"], t["gender"],  t["doB"],
          t["registrationNumber"], t["rollNumber"], t["class"]);
      print(Student);
      studentList.add(student);
    }
    print(studentList);
    return studentList;
  }

  Icon actionIcon = Icon(Icons.search);
  Widget appBarTitle = Text("Students");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
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
                  this.appBarTitle = Text("Students");
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
              future: _getStudents(),
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
                        return Container(
                          decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 1, color: Colors.black54)),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(snapshot.data[index].imgUrl),
                            ),
                            title: Text(snapshot.data[index].fullName),
                            subtitle: Text(
                              "Class:" +
                                  snapshot.data[index].class_ +
                                  "\n" +
                                  "DoB:" +
                                  snapshot.data[index].doB +
                                  "\n" +
                                  "Roll Number:" +
                                  snapshot.data[index].rollNumber,
                            ),
                            onTap:
                                () {Navigator.pushNamed(context, "/teacher/profile",arguments: snapshot.data[index].registrationNumber);}, //Supposed to take to profile page probably
                          ),
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
          Navigator.of(context).pushNamed('/students/create');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}




