import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 1));

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final Shader linearGradient = LinearGradient(
      colors: <Color>[Color(0xffff4343), Color(0xffaa2148)],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    return Scaffold(
        body: Stack(
      children: [
        Stack(
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
                      opacity: value,
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
        Positioned.fill(
            child: AnimatedBuilder(
                animation: animationController,
                builder: (context, snapshot) {
                  return ClipPath(
                      clipper: skinClipper(animationController.value),
                      child: Image.asset(
                        "assets/images/banner.jpg",
                        fit: BoxFit.fill,
                      ));
                })),
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
        height: size.height * 2 * value));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
