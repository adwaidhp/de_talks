import 'package:flutter/material.dart';
import 'package:de_talks/colors.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

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
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 300,
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
                          print('Navigate to login/register');
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
