import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';


class SignIn extends StatefulWidget {
   final Function toggleView;
    SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
    final Authservices _auth = Authservices();
    final _formKey = GlobalKey<FormState>();
    bool loading = false;

// text field state
String email = '';
String password = '';
String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Signin to Brew crew'),
        actions: [FlatButton.icon(
          onPressed: (){
             widget.toggleView();
          }, 
          icon: Icon(Icons.person), label: Text('Register'))],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical:20.0 , horizontal: 50.0),
        child: Form(
          key: _formKey,
          child:
           Column(
             children:
              [
             SizedBox(height:20.0),
             TextFormField(
                 decoration: textInputDecoration.copyWith(hintText:'Email'),
      validator:(val) => val.isEmpty ? 'Enter a valid  Email' : null,

               onChanged: (val) {
                  setState(() {
                    email = val;
                  });
               },
             ),

              SizedBox(height:20.0),
             TextFormField(
                 decoration: textInputDecoration.copyWith(hintText:'password'),
                              validator:(val) => val.length <6 ? 
               'please Enter a strong password(atleast 6 digit long )' : null,
               obscureText: true,
               onChanged: (val) {
                 setState(() {
                   password = val;
                 });
               },
               
             ) ,
             SizedBox(height:20.0),
             RaisedButton(
               color: Colors.pink[500],
               child: Text(
                 'Sign in',
                 style: TextStyle(
                   color: Colors.white,
                 ),
               ),
               onPressed: () async {
               if(_formKey.currentState.validate()){
                 setState(() =>  loading=true
                 );
                dynamic result = await _auth.signInWithEmailAndPassword(email, password);

               if(result == null){
                 setState(() {
                   error='Could not signed in with those credentials';
                   loading=false;
                 });
               }
              }
               },
               
             ),
               SizedBox(height:15),
             Text(error,
             style:TextStyle(color: Colors.red, fontSize: 14.0)
             
             ),
          ],)
        ),
      )
    );
  }
}