import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pho_pro/models/app_user.dart';
import 'package:pho_pro/screens/splash_screeen.dart';
import 'package:pho_pro/screens/wrapper.dart';
import 'package:pho_pro/services/auth.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  // runApp(MyApp());
}
// void main() {
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          'splashScreen': (BuildContext context) => SplashScreen(),
          'wrapper': (BuildContext context) => Wrapper(),
          // 'splashScreen':(BuildContext context)=>SplashScreen(),
        },
        home: Wrapper(),
        initialRoute: 'splashScreen',
      ),
    );
  }
}
