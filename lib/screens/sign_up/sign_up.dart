import 'package:book_club_app/screens/login/local_widgets/login_form.dart';
import 'package:book_club_app/screens/sign_up/local_widgets/sign_up_form.dart';
import 'package:flutter/material.dart';

class AppSignUp extends StatelessWidget {
  const AppSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20.0),
                children: const [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BackButton(),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  SignUpForm(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
