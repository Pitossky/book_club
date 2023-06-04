import 'package:book_club_app/screens/root/root.dart';
import 'package:book_club_app/states/current_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WELCOME'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Sign out'),
          onPressed: () async {
            CurrentUser _currentUser =
                Provider.of<CurrentUser>(context, listen: false);
            String _value = await _currentUser.signOut();
            if (_value == 'success') {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => AppRoot(),
                ),
                (route) => false,
              );
            }
          },
        ),
      ),
    );
  }
}
