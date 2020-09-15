import 'package:brew_crew/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Authservices {
final FirebaseAuth _auth = FirebaseAuth.instance;
// create user based on firebase user

 User _userFromFirebaseUser(FirebaseUser user) {
   return user != null ? User(uid:user.uid) : null;
  }
// auth change user
Stream<User> get user {
  return _auth.onAuthStateChanged
  //.map((FirebaseUser user) => _userFromFirebaseUser(user));
 .map(_userFromFirebaseUser);
}
// sign in with anonymus
Future signInAnon() async {
  try{
   AuthResult result = await _auth.signInAnonymously();
   FirebaseUser user = result.user;
   return _userFromFirebaseUser(user);
  } catch(e) {
  print(e.toString());
  return null;
  }
}
// signin with email and pass
Future signInWithEmailAndPassword(String email, String password) async {
  try {
  AuthResult result = await _auth.signInWithEmailAndPassword(email: email,
   password: password);
   FirebaseUser user = result.user;
   return _userFromFirebaseUser(user);
  } catch(e) {
  print(e.toString());
  return null;
  }
}

// register with email and password
Future registerWithEmailAndPassword(String email, String password) async {
  try {
  AuthResult result = await _auth.createUserWithEmailAndPassword(email: email,
   password: password);
   FirebaseUser user = result.user;
   return _userFromFirebaseUser(user);
  } catch(e) {
  print(e.toString());
  return null;
  }
}


// signout
Future signOut() async {
  try{
  return await _auth.signOut();
  } catch(e) {
  print(e.toString());
  return null;
  }
}


}