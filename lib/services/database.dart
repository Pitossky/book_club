import 'package:book_club_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(AppUsers users) async {
    String _value = 'error';

    try {
      await _firestore.collection('users').doc(users.uid).set({
        'fullName': users.fullName,
        'email': users.email,
        'accountCreated': Timestamp.now(),
      });
      _value = 'success';
    } catch (e) {
      print(e);
    }

    return _value;
  }

  Future<AppUsers> getUserInfo(String uid) async {
    AppUsers _value = AppUsers();

    try{
      DocumentSnapshot _docSnap = await _firestore.collection('users').doc(uid).get();
      final data = _docSnap.data()! as Map<String, dynamic>;
      AppUsers _users = AppUsers(
        uid: uid,
        fullName: data['fullName'],
        email: data['email'],
        accountCreated: data['accountCreated'],
      );
     _value = _users;
    } catch(e){
      print(e);
    }

    return _value;
  }
}
