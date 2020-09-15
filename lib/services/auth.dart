import 'package:firebase_auth/firebase_auth.dart';
class Authservices {
final FirebaseAuth _auth = FirebaseAuth.instance;

// sign in with anonymus
Future signInAnon() async {
  try{
   AuthResult result = await _auth.signInAnonymously();
   FirebaseUser user = result.user;
   return user;
  } catch(e) {
  print(e.toString());
  return null;
  }
}
// signin with email and pass


// register with email and password

// signout

}