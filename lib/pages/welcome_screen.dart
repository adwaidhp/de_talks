import 'package:de_talks/pages/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:de_talks/colors.dart';
import 'dart:async';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool _isLoaded = false;
  Timer? _animationTimer;

  static const int pauseTime = 1000;
  static const int animationTime = 1500;

  void _startAnimationCycle() {
    setState(() => _isLoaded = false);
    Future.delayed(Duration(milliseconds: pauseTime), () {
      setState(() => _isLoaded = true);
      Future.delayed(Duration(milliseconds: animationTime + pauseTime), () {
        setState(() => _isLoaded = false);

        Future.delayed(Duration(milliseconds: animationTime), () {
          _startAnimationCycle();
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _startAnimationCycle();
  }

  @override
  void dispose() {
    _animationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/WelcomePageBg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SizedBox.expand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'Welcome to Detalks.',
                    style: const TextStyle(
                      fontSize: 40,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textHeightBehavior: const TextHeightBehavior(
                      applyHeightToFirstAscent: false,
                      applyHeightToLastDescent: false,
                    ),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: animationTime),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(vertical: 24),
                transform: Matrix4.identity()
                  ..translate(190.0, 100.0)
                  ..rotateZ(_isLoaded ? 0 : -(45 * 3.14159) / 180)
                  ..scale(_isLoaded ? 1.0 : 0.6)
                  ..translate(-190.0, -100.0),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 400,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.only(top: 24),
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                    border: Border.all(
                      color: AppColors.black,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Together, we rise above addiction.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // TODO: Navigate to login/register page
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const RegisterScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.black,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 120,
                            vertical: 30,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
