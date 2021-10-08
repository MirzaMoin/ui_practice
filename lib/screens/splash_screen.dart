import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_practice/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this,
        duration: Duration(seconds: 2),
        lowerBound: 0.0,
        upperBound: 2.0);

    Future.delayed(Duration(seconds: 1), () {
      animationController.forward();
    });
    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(builder: (_) => MainScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final Shader linearGradient = LinearGradient(
      colors: <Color>[Color(0xffff4343), Color(0xffaa2148)],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "assets/images/banner.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xffff4343).withOpacity(0.7),
                      Color(0xff2143aa).withOpacity(0.7)
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned.fill(
          child: AnimatedBuilder(
              animation: animationController,
              builder: (context, snapshot) {
                return ClipPath(
                  clipper: skinClipper(animationController.value),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        "assets/images/banner.jpg",
                        fit: BoxFit.cover,
                      ),
                      Container(
                        color: Colors.black.withOpacity(0.85),
                      ),
                      Positioned.fill(
                        top: -MediaQuery.of(context).size.height * 0.1,
                        child: AnimatedBuilder(
                            animation: animationController,
                            builder: (context, snapshot) {
                              final value = animationController.value;
                              return AnimatedOpacity(
                                duration: Duration(seconds: 1),
                                opacity: value == 2.0 ? 1 : 0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/logo.png",
                                      height: 130,
                                      width: 130,
                                    ),
                                    Text(
                                      "MOVIE STUDIO",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        /*    foreground: Paint()..shader = linearGradient*/
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                      Positioned(
                          bottom: 20,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Text(
                              "HD PRINTS",
                              style: TextStyle(
                                  fontSize: 40,
                                  fontFamily: GoogleFonts.prompt().fontFamily,
                                  foreground: Paint()..shader = linearGradient),
                            ),
                          ))
                    ],
                  ),
                );
              }),
        ),
      ],
    ));
  }
}

class skinClipper extends CustomClipper<Path> {
  final double value;

  skinClipper(this.value);

  @override
  Path getClip(Size size) {
    final path = Path();
    Offset center;

    center = Offset(size.width / 2, size.height / 2);

    path.addOval(Rect.fromCenter(
        center: center,
        width: size.width * 2 * value,
        height: size.height * 1 * value));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
