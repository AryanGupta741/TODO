import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/firebase_options.dart';
import 'package:todo_list/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_list/pages/Home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(todo());
}

class todo extends StatelessWidget {
  const todo({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, userSnapshot) {
            if (userSnapshot.hasData) {
              return const homePage();
            } else {
              return  HomePage();
            }
          }),
    );
  }
}
