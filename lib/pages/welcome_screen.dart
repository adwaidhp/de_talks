import 'package:de_talks/pages/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:de_talks/colors.dart';
import 'dart:async';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: -45 * 3.14159 / 180,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.6,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _startAnimationCycle();
  }

  void _startAnimationCycle() async {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 1000));
      if (!mounted) return;
      await _controller.forward();
      await Future.delayed(const Duration(milliseconds: 1000));
      if (!mounted) return;
      await _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
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
                    'Welcome to DeTalks.',
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
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..rotateZ(_rotationAnimation.value)
                        ..scale(_scaleAnimation.value),
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 400,
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
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
