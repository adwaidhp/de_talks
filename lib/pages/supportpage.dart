import 'package:de_talks/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  void _onReportDrugAbuse() {
    // Template function for drug abuse reporting
    print('Report Drug Abuse clicked');
  }

  void _onSupportSection2() {
    // Template function for support section 2
    print('Support Section 2 clicked');
  }

  void _onSupportSection3() {
    // Template function for support section 3
    print('Support Section 3 clicked');
  }

  void _onChatButtonPressed() {
    print('Chat button pressed');
    // Add your chat functionality here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/SupportPageBg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 23),
              child: Text(
                "Support",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 32,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: GestureDetector(
                onTap: _onReportDrugAbuse,
                child: Container(
                  width: 357,
                  height: 151,
                  padding: const EdgeInsets.all(23),
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      "🚨Report Drug Abuse🚨",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 23),
              child: Text(
                "Resources",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 32,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: GestureDetector(
                onTap: _onSupportSection2,
                child: Container(
                  width: 357,
                  height: 180,
                  padding: const EdgeInsets.all(23),
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/vimukthi.png',
                          height: 124,
                          width: 500,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 357,
                child: Text(
                  "Click above to load Vimukthi De-addiction\ncentres list",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: GestureDetector(
                onTap: _onSupportSection3,
                child: Container(
                  width: 357,
                  height: 169,
                  padding: const EdgeInsets.all(23),
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "National Toll Free Drug De-\nAddiction Helpline Number",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/Phone.svg',
                              height: 30,
                              width: 40,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              "1800 - 11 - 0031",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onChatButtonPressed,
        backgroundColor: AppColors.lightBlueAccent,
        shape: const CircleBorder(),
        elevation: 4.0,
        child: SvgPicture.asset(
          'assets/icons/Chat.svg',
          height: 30,
          width: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
