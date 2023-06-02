import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CurrentUser extends ChangeNotifier {
  String? _userId;
  String? _userEmail;

  String? get userId => _userId;
  String? get userEmail => _userEmail;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signupUser(String email, String password) async {
    bool returnValue = false;

    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(_authResult.user != null){
        _userId = _authResult.user!.uid;
        _userEmail = _authResult.user!.email;
        returnValue = true;
      }
    } catch (e) {
      print(e);
    }
    return returnValue;
  }

  Future<bool> loginUser(String email, String password) async {
    bool returnValue = false;

    try {
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(_authResult.user != null){
        returnValue = true;
      }
    } catch (e) {
      print(e);
    }
    return returnValue;
  }
}
