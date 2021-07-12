import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:uuid/uuid.dart';
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

class CreateMeeetingScreen extends StatefulWidget {

  @override
  _CreateMeeetingScreenState createState() => _CreateMeeetingScreenState();
}

class _CreateMeeetingScreenState extends State<CreateMeeetingScreen> {
  TextEditingController _controller = TextEditingController();
  String code = "";
  var isVis = false;

  generateMeetingCode() {
    setState(() {
      code = Uuid().v1().substring(0,6);
      isVis=true;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final key = new GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: Colors.black,
      key: key,
      body: Column(

        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              "Create a code to create a meeting!",
              style: montserratStyle(20,Colors.white, ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          isVis == true? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Code: ",
                style: ralewayStyle(30,Colors.white,),
              ),
    

              GestureDetector(
                child: Text(
                    code,
                  style: montserratStyle(30, Colors.red, FontWeight.w700),

                ),
                onLongPress: () {
                  Clipboard.setData(new ClipboardData(text: code));
                  key.currentState.showSnackBar(
                      new SnackBar(content: new Text("Copied to Clipboard"),));
                },
              ),
            ],
          ): Container(),
          SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: generateMeetingCode,
                      child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: GradientColors.facebookMessenger,
                ),
              ),
              child: Center(
                child: Text(
                  "Create Code",
                  style: montserratStyle(20, Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
