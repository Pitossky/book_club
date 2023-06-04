import 'package:book_club_app/screens/home/home.dart';
import 'package:book_club_app/screens/sign_up/sign_up.dart';
import 'package:book_club_app/widgets/app_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../states/current_user.dart';

enum LoginType { email, google }

class AppLoginForm extends StatefulWidget {
  const AppLoginForm({Key? key}) : super(key: key);

  @override
  State<AppLoginForm> createState() => _AppLoginFormState();
}

class _AppLoginFormState extends State<AppLoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _loginUser({
    required LoginType loginType,
    String? email,
    String? password,
    required BuildContext context,
  }) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    try {
      String _returnValue = '';

      switch(loginType){
        case LoginType.email:
          _returnValue = await _currentUser.loginUserWithEmail(email!, password!);
          break;
        case LoginType.google:
          _returnValue = await _currentUser.loginUserWithGoogle();
          break;
        default:
      }

      if (_returnValue == 'success') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_returnValue.toString()),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('login error: $e');
    }
  }

  Widget _googleButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        surfaceTintColor: Colors.grey,
        elevation: 0,
        side: const BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
      onPressed: () {
        _loginUser(
          loginType: LoginType.google,
          context: context,
        );
      },
      child: const Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage("assets/google_logo.png"),
              height: 25.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 8.0,
            ),
            child: Text(
              'Log In',
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.alternate_email),
              hintText: 'Email',
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.lock_outline),
              hintText: 'Password',
            ),
            obscureText: true,
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: () {
              _loginUser(
                loginType: LoginType.email,
                email: _emailController.text,
                password: _passwordController.text,
                context: context,
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 100.0),
              child: Text(
                'Log in',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const AppSignUp(),
                ),
              );
            },
            child: const Text("Don't have an account? Sign up here."),
          ),
          _googleButton(),
        ],
      ),
    );
  }
}
