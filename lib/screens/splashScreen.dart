import 'package:flutter/material.dart';
import 'package:flutter_news_app/screens/login.dart';
import 'package:flutter_news_app/theme/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () async {
      Navigator.of(context).pushReplacement(_animateRoute());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundLight,
      body: Center(
        child: Image(
          image: AssetImage("assets/images/news.png"),
        ),
      ),
    );
  }
}

Route _animateRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Login(),
    transitionDuration: Duration(seconds: 3),
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        ScaleTransition(
      scale: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeInQuad),
      ),
      child: child,
    ),
  );
}
