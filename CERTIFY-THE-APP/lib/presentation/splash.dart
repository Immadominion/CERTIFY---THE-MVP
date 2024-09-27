import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:certify/main.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class CertifySplash extends StatefulWidget {
  const CertifySplash({super.key});

  @override
  CertifySplashState createState() => CertifySplashState();
}

class CertifySplashState extends State<CertifySplash>
    with TickerProviderStateMixin {
  late AnimationController scaleController;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            Navigator.of(context).pushReplacement(
              PageTransition(
                type: PageTransitionType.bottomToTop,
                child: const MyApp(),
              ),
            );
            Timer(
              const Duration(milliseconds: 300),
              () {
                scaleController.reset();
              },
            );
          }
        },
      );

    scaleAnimation =
        Tween<double>(begin: 0.0, end: 12).animate(scaleController);

    Timer(const Duration(seconds: 2), () {
      setState(() {
        scaleController.forward();
      });
    });
  }

  @override
  void dispose() {
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff412EEF),
      body: Center(
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyLarge ?? const TextStyle(),
          child: AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                'C E R T I F Y',
                speed: const Duration(milliseconds: 100),
              ),
            ],
            isRepeatingAnimation: false,
            repeatForever: false,
            displayFullTextOnTap: false,
          ),
        ),
      ),
    );
  }
}
