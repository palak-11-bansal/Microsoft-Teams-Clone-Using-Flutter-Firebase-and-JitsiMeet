import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
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

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var username = "";
  var isData = false;
  TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var uid = FirebaseAuth.instance.currentUser.uid;
    DocumentSnapshot data = await userCollection.doc(uid).get();
    setState(() {
      username = data["username"];
      isData = true;
    });
  }

  editProfile() {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.black,
            child: Container(
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Edit Profile",
                    style: ralewayStyle(20, Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: _editingController,
                      decoration: InputDecoration(
                        hintText: "Username",
                        hintStyle: ralewayStyle(17, Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      userCollection
                          .doc(FirebaseAuth.instance.currentUser.uid)
                          .update({"username": _editingController.text});
                      setState(() {
                        username = _editingController.text;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: 20,
                      color: Colors.red,
                      child: Center(
                        child: Text(
                          "Edit",
                          style: ralewayStyle(20, Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        body: isData == false
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  ClipPath(
                    clipper: OvalBottomBorderClipper(),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 2.5,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: GradientColors.facebookMessenger,
                      )),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 2 - 64,
                      top: MediaQuery.of(context).size.height / 3.1,
                    ),
                    child: CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage(
                        "https://i.stack.imgur.com/l60Hf.png",
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 300,
                        ),
                        Text(
                          username,
                          style: montserratStyle(30, Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: editProfile,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 40,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: GradientColors.facebookMessenger)),
                            child: Center(
                              child: Text(
                                "Edit Profile",
                                style: montserratStyle(17, Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ));
  }
}
