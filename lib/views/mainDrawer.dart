import 'package:flutter/material.dart';


class MainDrawer extends StatelessWidget {

  _listTile(icon, text, path, context){
    return ListTile(
      leading: Icon(icon),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      onTap: (){
        if(path!=null){
          Navigator.of(context).pushNamed(path);
        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 30, bottom: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://i.stack.imgur.com/l60Hf.png'),
                            fit: BoxFit.cover),
                      )),
                  Text(
                    "UserName",
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  Text(
                    "UserEmail@email.com",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          _listTile(Icons.person, "Profile", "/profile", context),
          _listTile(Icons.face,"Students", null, context),
          _listTile(Icons.school,"Teachers", '/teachers', context),
          _listTile(Icons.account_balance,"School", null, context),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                leading: Icon(Icons.arrow_back),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
