import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:todo_list/screens/authform_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          // we will give media query height
          // double.infinity make it big as my parent allows
          // while MediaQuery make it big as per the screen

          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            // even space distribution
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "स्वागतम",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Don’t wait. The time will never be just right.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                    ),
                  )
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: Lottie.asset(
                  'assets/Animation - 1706881284715.json', // Replace with the URL to your Lottie animation JSON file
                  
                  // Other properties like repeat, reverse, etc., can be added here
                ),
                decoration: BoxDecoration(),
              ),
              Column(
                children: <Widget>[
                  // the login button
                  // MaterialButton(
                  //   minWidth: double.infinity,
                  //   height: 60,
                  //   onPressed: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) => authForm()));
                  //   },
                  //   // defining the shape
                  //   shape: RoundedRectangleBorder(
                  //       side: BorderSide(color: Colors.black),
                  //       borderRadius: BorderRadius.circular(50)),
                  //   child: Text(
                  //     "Login",
                  //     style:
                  //         TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  //   ),
                  // ),
                  // creating the signup button
                  SizedBox(height: 20),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => authForm()));
                    },
                    color: Color(0xff0095FF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      "Register",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
