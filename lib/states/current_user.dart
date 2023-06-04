import 'package:book_club_app/models/user_model.dart';
import 'package:book_club_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CurrentUser extends ChangeNotifier {
  AppUsers? _currentUser;

  AppUsers? get currentUser => _currentUser;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> onStartUp() async {
    String returnValue = 'failure';

    try {
      User? _firebaseUser = _auth.currentUser;
      if (_firebaseUser != null) {
        _currentUser = await AppDatabase().getUserInfo(_firebaseUser.uid);
        if(_currentUser != null) returnValue = 'success';
        // _currentUser.uid = _firebaseUser.uid;
        // _currentUser.email = _firebaseUser.email;
        // returnValue = 'success';
      } else {
        returnValue = 'failure';
      }
    } catch (e) {
      print('auth error: $e');
    }
    return returnValue;
  }

  Future<String> signOut() async {
    String returnValue = 'failure';

    try {
      await _auth.signOut();
      _currentUser = AppUsers();
      returnValue = 'success';
    } catch (e) {
      print('auth error: $e');
    }
    return returnValue;
  }

  Future<String> signupUser(
    String email,
    String password,
    String fullName,
  ) async {
    String returnValue = 'failure';
    AppUsers _user = AppUsers();

    try {
      UserCredential _userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user.uid = _userCredential.user!.uid;
      _user.email = _userCredential.user!.email;
      _user.fullName = fullName;
      String _returnString = await AppDatabase().createUser(_user);
      if(_returnString == 'success') returnValue = 'success';
    } on PlatformException catch (e) {
      returnValue = e.toString();
    } catch (e) {
      print(e);
    }
    return returnValue;
  }

  Future<String> loginUserWithEmail(String email, String password) async {
    String returnValue = 'failure';

    try {
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _currentUser = await AppDatabase().getUserInfo(_authResult.user!.uid);
      if(_currentUser != null) returnValue = 'success';
      // _currentUser.uid = _authResult.user!.uid;
      // _currentUser.email = _authResult.user!.email;
      // returnValue = 'success';
    } catch (e) {
      returnValue = e.toString();
    }
    return returnValue;
  }

  Future<String> loginUserWithGoogle() async {
    String returnValue = 'failure';
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    AppUsers _appUser = AppUsers();

    try {
      GoogleSignInAccount? _googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication _googleAuth =
          await _googleUser!.authentication;
      final AuthCredential _userCredential = GoogleAuthProvider.credential(
        idToken: _googleAuth.idToken,
        accessToken: _googleAuth.accessToken,
      );
      UserCredential _authResult =
          await _auth.signInWithCredential(_userCredential);
      if(_authResult.additionalUserInfo!.isNewUser){
        _appUser.uid = _authResult.user!.uid;
        _appUser.email = _authResult.user!.email;
        _appUser.fullName = _authResult.user!.displayName;
        AppDatabase().createUser(_appUser);
      }
      // _currentUser.uid = _authResult.user!.uid;
      // _currentUser.email = _authResult.user!.email;
      _currentUser = await AppDatabase().getUserInfo(_authResult.user!.uid);
      if(_currentUser != null) returnValue = 'success';
    } catch (e) {
      returnValue = e.toString();
    }
    return returnValue;
  }
}
