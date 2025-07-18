import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/main.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_glow/flutter_glow.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changescreen() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  void initState() {
    changescreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(decoration: BoxDecoration(color: Colors.black)),
          Center(
            child: Container(
              height: 250,
              width: 250,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.orange,

                borderRadius: BorderRadius.circular(20),
              ),
              child: Animate(
                effects: [
                  FadeEffect(duration: const Duration(milliseconds: 1000)),
                ],
                child: GlowText(
                  glowColor: const Color.fromARGB(250, 0, 0, 0),
                  'Quizyy',
                  style: TextStyle(
                    fontSize: 60,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                    fontStyle: GoogleFonts.poppins().fontStyle,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}
