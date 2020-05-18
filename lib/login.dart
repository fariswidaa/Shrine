import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset('assets/diamond.png'),
                SizedBox(height: 16.0),
                Text('SHRINE'),
              ],
            ),
            SizedBox(height: 120.0),
            // TODO: Add TextField widgets (101)
            TextField(
              controller: passwordEditingController,
              decoration: InputDecoration(filled: true, labelText: 'User Name'),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: nameEditingController,
              decoration: InputDecoration(filled: true, labelText: 'Password'),
              obscureText: true,
            ),

            ButtonBar(
              children: <Widget>[
                FlatButton(
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    ),
                    child: Text('Cancel'),
                    onPressed: () {
                      nameEditingController.clear();
                      passwordEditingController.clear();
                    }),
                RaisedButton(
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    ),
                    elevation: 8.0,
                    child: Text('Next'),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
