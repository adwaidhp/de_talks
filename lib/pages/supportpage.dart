import 'package:de_talks/colors.dart';
import 'package:de_talks/pages/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  // Constants
  static const String _ncbManasUrl = 'https://www.ncbmanas.gov.in/createTicket';
  static const String _vimukhtiUrl = 'https://vimukthi.kerala.gov.in/';
  static const String _helplineNumber = '18001100031';

  /// Launches a URL and shows error message if launch fails
  Future<void> _launchUrl(BuildContext context, String url) async {
    // Capture the context in a local variable
    final currentContext = context;
    try {
      if (!await launchUrl(Uri.parse(url))) {
        if (currentContext.mounted) {
          _showSnackBar(currentContext, 'Could not launch $url');
        }
      }
    } catch (e) {
      if (currentContext.mounted) {
        _showSnackBar(currentContext, 'Error launching URL: $e');
      }
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _onReportDrugAbuse(BuildContext context) {
    _launchUrl(context, _ncbManasUrl);
  }

  void _onSupportSection2(BuildContext context) {
    _launchUrl(context, _vimukhtiUrl);
  }

  Future<void> _callHelpline(BuildContext context) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: _helplineNumber);
    // Capture the context in a local variable
    final currentContext = context;
    try {
      if (!await launchUrl(phoneUri)) {
        if (currentContext.mounted) {
          _showSnackBar(currentContext, 'Could not launch phone dialer');
        }
      }
    } catch (e) {
      if (currentContext.mounted) {
        _showSnackBar(currentContext, 'Error launching phone dialer: $e');
      }
    }
  }

  void _onChatButtonPressed(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatScreen(),
      ),
    );
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
                    onTap: () => _onReportDrugAbuse(context),
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
                    onTap: () => _onSupportSection2(context),
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
                const SizedBox(height: 32),
                // Helpline Container
                Center(
                  child: GestureDetector(
                    onTap: () => _callHelpline(context),
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
                          InkWell(
                            onTap: () => _callHelpline(context),
                            child: Row(
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
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ChatScreen(),
              ),
            );
          },
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
