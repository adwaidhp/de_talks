import 'package:de_talks/colors.dart';
import 'package:de_talks/pages/chat_screen.dart';
import 'package:de_talks/pages/urgesurf.dart';
import 'package:de_talks/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  bool isHovered = false;

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
        builder: (context) => UrgeSurfingPage(),
      ),
    );
  }

  Widget _buildSupportCard({
    required String title,
    required VoidCallback onTap,
    required Widget child,
    double height = 160,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
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
            if (title.isNotEmpty) ...[
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 16),
            ],
            Expanded(child: Center(child: child)),
          ],
        ),
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
                Text(
                  "Support.",
                  style: AppTextStyles.bold.copyWith(
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 30),

                // Report Abuse Card
                _buildSupportCard(
                  title: "",
                  onTap: () => _onReportDrugAbuse(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.warning_amber_rounded,
                          size: 50, color: Colors.red),
                      const SizedBox(height: 12),
                      const Text(
                        "Report Drug Abuse",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Helpline Card
                _buildSupportCard(
                  title: "De-Addiction Helpline",
                  onTap: () => _callHelpline(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.red, width: 2),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.phone,
                                color: Colors.red, size: 28),
                            const SizedBox(width: 12),
                            const Text(
                              "1800-11-0031",
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
                const SizedBox(height: 60),

                Text(
                  "Resources.",
                  style: AppTextStyles.bold.copyWith(
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 30),

                // Vimukthi Card
                _buildSupportCard(
                  title: "",
                  onTap: () => _onSupportSection2(context),
                  child: Image.asset(
                    'assets/images/vimukthi.png',
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 30),

                // Urge Surfing Card
                _buildSupportCard(
                  title: "",
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UrgeSurfingPage(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.waves,
                        size: 50,
                        color: AppColors.darkBlueContrast,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Urge Surfing",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 5,
        ),
        child: MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isHovered ? 110 : 60,
            height: 60,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(),
                  ),
                );
              },
              backgroundColor: AppColors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 4.0,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.centerRight,
                children: [
                  if (isHovered)
                    Positioned(
                      right: 60,
                      child: const Text(
                        'Chat',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  Positioned(
                    right: 15,
                    child: SvgPicture.asset(
                      'assets/icons/Chat.svg',
                      colorFilter: ColorFilter.mode(
                        AppColors.darkBlueContrast,
                        BlendMode.srcIn,
                      ),
                      height: 30,
                      width: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
