import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                  color: const Color(0xFFCFE7F3),
                  borderRadius: BorderRadius.circular(10),
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
                height: 151,
                padding: const EdgeInsets.all(23),
                decoration: BoxDecoration(
                  color: const Color(0xFFCFE7F3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/vimukthi.png',
                        height: 80,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Vimukthi Centers",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
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
                style: TextStyle(
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
                height: 151,
                padding: const EdgeInsets.all(23),
                decoration: BoxDecoration(
                  color: const Color(0xFFCFE7F3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Support Section 3",
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
        ],
      ),
    );
  }
}
