import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController nameEditingController = TextEditingController() ;
  TextEditingController passwordEditingController = TextEditingController() ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    resizeToAvoidBottomInset : false ,
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
              controller : passwordEditingController,
              decoration : InputDecoration(
                filled : true ,
                labelText : 'User Name'
              ),
            ),
            SizedBox(height : 12.0),
            TextField(
              controller : nameEditingController,
              decoration : InputDecoration(
                filled : true ,
                labelText : 'Password'
              ),
              obscureText: true,
            ),

            ButtonBar(
              children: <Widget>[
               FlatButton(
                child : Text('Cancel'),
                onPressed : () {
                  nameEditingController.clear();
                  passwordEditingController.clear();
                }
               ),
               RaisedButton(
                child : Text('Next'),
                onPressed : () {
                 Navigator.pop(context);
                }
               ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
