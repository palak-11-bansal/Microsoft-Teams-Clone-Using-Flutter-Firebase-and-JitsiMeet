import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:zoom_clone/screens/meeting_screen.dart';
import 'package:zoom_clone/screens/profile_screen.dart';
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
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int page = 0;
  List pageOptions = [
    MeetingScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blue,
        selectedLabelStyle: montserratStyle(17, Colors.blue),
        unselectedItemColor: Colors.white,
        unselectedLabelStyle: montserratStyle(17, Colors.black),
        currentIndex: page,
        onTap: (idx) {
          setState(() {
            page = idx;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.video_call, size: 32,),
            title: Text("Meetings"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 32,),
            title: Text("Profile"),
          ),
        ],
      ),
      body: pageOptions[page],
    );
  }
}