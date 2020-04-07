import 'package:flutter/material.dart';
import 'package:layout/userProfileView.dart';
import './homeScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/':(_)=>LoginPage(),
        '/home': (_)=>Homescreen(),
        '/profile': (_)=>UserProfileView()
      },
      theme: ThemeData(primaryColor: Colors.black),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
              padding: const EdgeInsets.all(40.0),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 40),
                  child: FlutterLogo(
                    colors: Colors.blue,
                    size: 100,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Theme(
                      //ThemeData
                      data: ThemeData(
                        brightness: Brightness.light, 
                        primarySwatch: Colors.blue,
                        inputDecorationTheme: InputDecorationTheme(
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0
                          )
                        )
                      ),
                      //Actual Widgets
                      child: Column(children: <Widget>[
                        //Email Entry Field
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Email",
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (String value){
                            if (value.isEmpty){return "Field can not be left empty.";}
                            else{return null;}
                          },
                        ),
                        //Password Entry Field
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Password",
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          validator: (String value){
                            if (value.isEmpty){return "Field can not be left empty.";}
                            else{return null;}
                          },
                        ),
                        Padding(padding: const EdgeInsets.only(top: 40.0)),
                        MaterialButton(
                          height: 40.0,
                          minWidth: 100.0,
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          child: Text('Login'),
                          splashColor: Colors.lightBlue,
                          onPressed: (){
                            if(_formKey.currentState.validate()){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Homescreen()));
                            }
                            },
                          )
                    ],),
                  )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

