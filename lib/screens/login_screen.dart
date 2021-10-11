import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:ui_practice/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: EdgeInsets.only(top: 50),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(13),
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        border: Border.all(
                            color: Theme.of(context).accentColor, width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset(
                      "assets/icons/ic_back_arrow.png",
                      width: 15,
                      height: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Text(
                  "Log in",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Email",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                Container(
                  padding: EdgeInsets.only(left: 12, top: 5, bottom: 5),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).accentColor.withOpacity(0.5)),
                  child: TextField(
                    cursorColor: Color(0xff2c3254),
                    maxLines: 1,
                    style: TextStyle(color: Color(0xff2c3254)),
                    decoration: InputDecoration(
                      hintText: "Enter Email",
                      border: InputBorder.none,
                      prefixIconConstraints: BoxConstraints(
                          maxHeight: 30,
                          maxWidth: 30,
                          minHeight: 20,
                          minWidth: 20),
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                Text(
                  "Password",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                Container(
                  padding: EdgeInsets.only(left: 12, top: 5, bottom: 5),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).accentColor.withOpacity(0.5)),
                  child: TextField(
                    cursorColor: Color(0xff2c3254),
                    maxLines: 1,
                    style: TextStyle(color: Color(0xff2c3254)),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(),
                      hintText: "Enter Password",
                      border: InputBorder.none,
                      prefixIconConstraints: BoxConstraints(
                          maxHeight: 30,
                          maxWidth: 30,
                          minHeight: 20,
                          minWidth: 20),
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 12),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).accentColor),
                  child: MaterialButton(
                    onPressed: () {},
                    child: Text(
                      "Log In",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Log in with one of the following options",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.5), fontSize: 15),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.09,
                        margin: EdgeInsets.only(top: 10, bottom: 10, right: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).accentColor),
                        child: MaterialButton(
                            onPressed: () {},
                            child: Image.asset(
                              "assets/icons/ic_google.png",
                              height: 30,
                              width: 30,
                              color: Colors.white,
                            )),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.09,
                        margin: EdgeInsets.only(top: 10, bottom: 10, left: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).accentColor),
                        child: MaterialButton(
                            onPressed: () {},
                            child: Image.asset(
                              "assets/icons/ic_facebook.png",
                              height: 30,
                              width: 30,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 30,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5), fontSize: 15),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => SignUpScreen()));
                    },
                    child: Text(
                      "Sign up!      ",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.7), fontSize: 16),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
