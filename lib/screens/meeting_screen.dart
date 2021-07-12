import "package:flutter/material.dart";
import 'package:zoom_clone/screens/create_meeting_screen.dart';
import 'package:zoom_clone/screens/join_meeting_screen.dart';
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

class MeetingScreen extends StatefulWidget {
  @override
  _MeetingScreenState createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  tabBuilder(String name) {
    return Container(

      width: 150,
      height: 45,
      child: Card(
        color: Colors.blue,
        child: Center(
          child: Text(
            name,
            style: ralewayStyle(
              13,
              Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Microsoft Teams",
          style: ralewayStyle(18, Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        bottom: TabBar(
          controller: tabController,
          tabs: [
            tabBuilder("Join Meeting"),
            tabBuilder("Create Meeting"),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          JoinMeetingScreen(),
          CreateMeeetingScreen(),
        ],
      ),
    );
  }
}
