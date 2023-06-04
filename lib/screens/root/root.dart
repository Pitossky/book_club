import 'package:book_club_app/screens/home/home.dart';
import 'package:book_club_app/screens/login/login.dart';
import 'package:book_club_app/states/current_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthStatus {
  notLoggedIn,
  loggedIn,
}

class AppRoot extends StatefulWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  AuthStatus _authStatus = AuthStatus.notLoggedIn;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnValue = await _currentUser.onStartUp();
    if(_returnValue == 'success'){
      _authStatus = AuthStatus.loggedIn;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget returnValue = Container();

    switch(_authStatus){
      case AuthStatus.notLoggedIn:
        returnValue = const AppLogin();
        break;
      case AuthStatus.loggedIn:
        returnValue = const HomeScreen();
      default:
    }

    return returnValue;
  }
}
