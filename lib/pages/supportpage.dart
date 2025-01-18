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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const Text(
                  "Support",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 20),
                // Report Drug Abuse Container
                Center(
                  child: GestureDetector(
                    onTap: _onReportDrugAbuse,
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            color: AppColors.blackOverlay,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "🚨Report Drug Abuse🚨",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Resources",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 20),
                // Vimukthi Container
                Center(
                  child: GestureDetector(
                    onTap: _onSupportSection2,
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            color: AppColors.blackOverlay,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/vimukthi.png',
                          height: 140,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Center(
                  child: Text(
                    "Click above to load Vimukthi De-addiction\ncentres list",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Helpline Container
                Center(
                  child: GestureDetector(
                    onTap: _onSupportSection3,
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            color: AppColors.blackOverlay,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "National Toll Free Drug De-\nAddiction Helpline Number",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/Phone.svg',
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                "1800 - 11 - 0031",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
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
                const SizedBox(height: 40),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 5,
        ),
        child: FloatingActionButton(
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
      ),
    );
  }
}
