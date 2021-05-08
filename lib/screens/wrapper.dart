import 'package:flutter/material.dart';
import 'package:pho_pro/models/app_user.dart';
import 'package:pho_pro/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appUser = Provider.of<AppUser>(context);
    // print('here we go');
    // print(appUser.uid);
    if (appUser == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
