import 'package:book_club_app/screens/login/local_widgets/login_form.dart';
import 'package:flutter/material.dart';

class AppLogin extends StatelessWidget {
  const AppLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20.0),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Image.asset("assets/book_club_logo.png"),
                  ),
                  const SizedBox(height: 20.0),
                  const AppLoginForm(),
                ],
              ),
          )
        ],
      ),
    );
  }
}
