import "package:flutter/material.dart";
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:zoom_clone/screens/login_screen.dart';
import 'package:zoom_clone/screens/sign_up_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle ralewayStyle(double size,[Color color, FontWeight fontWeight = FontWeight.w700]) {
  return GoogleFonts.raleway(
    fontSize: size,
    color: color,
    fontWeight: fontWeight,
  );
}

TextStyle montserratStyle(double size,[Color color, FontWeight fontWeight = FontWeight.w700]) {
  return GoogleFonts.montserrat(
    fontSize: size,
    color: color,
    fontWeight: fontWeight,
  );
}

CollectionReference userCollection = FirebaseFirestore.instance.collection("users");

class NavigateAuthScreen extends StatefulWidget {
  @override
  _NavigateAuthScreenState createState() => _NavigateAuthScreenState();
}

class _NavigateAuthScreenState extends State<NavigateAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              color: Colors.black,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text("Welcome to Microsoft Teams",
                    style: montserratStyle(22, Colors.white),),

                  ),
                  SizedBox(
                    height: 150,
                  ),
                  // Center(child: Text("click here to", style: TextStyle(color: Colors.white),
                  // ),

                  // ),
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => LoginScreen())),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: GradientColors.blue),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "Login",
                          style: ralewayStyle(30, Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => SignUpScreen())),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: GradientColors.blue),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "Sign Up",
                          style: ralewayStyle(30, Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
