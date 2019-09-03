import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymbuddy/pages/setup/signIn.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
String _email, _password;
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

 @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Form(
        key: _formKey,
        child: Column(

          
          children: <Widget>[
            TextFormField(
              validator: (input){
                if(input.isEmpty) {
                  return 'Please type an email';
                }
              },
              onSaved: (input) => _email = input,
              decoration: InputDecoration(  
                labelText: 'Email'
              ),

            ),
            TextFormField(
              validator: (input){
                if(input.length < 6) {
                  return 'Your password needs to be at least 6 characters';
                }
              },
              onSaved: (input) => _password = input,
              decoration: InputDecoration(  
                labelText: 'Password'
              ),
              obscureText: true,

            ),
            RaisedButton(
              onPressed: signUp,
              child: Text('Sign Up'),
            )
          ],
        ),
      ),
    );
  }
  Future<void> signUp() async{
  //validate fields
  //login to firebase
  final formState = _formKey.currentState;
  if(formState.validate()){
    //login to firebase
    formState.save();
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
    } catch(e) {
      print(e.message);
    }
  } 
}
}