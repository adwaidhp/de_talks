import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:de_talks/colors.dart';
import 'package:de_talks/models/events.dart';
import 'package:de_talks/services/event_service.dart';
import 'package:de_talks/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class Profilepage extends StatefulWidget {
  Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  int count = 0;

  String name = '';
  String city = '';
  void getUserDetails() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      return;
    }

    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userDoc.exists && userDoc.data() != null) {
      setState(() {
        count = userDoc.data()?['dayCount'] ?? 0;
        name = userDoc.data()?['name'] ?? 'Alex';
        city = userDoc.data()?['city'] ??
            'Thrissur'; // Use 0 as a default if 'count' is not set
      });
    }
  }

  // Future<void> _launchSocialMedia(BuildContext context, String url) async {
  //   try {
  //     if (!await launchUrl(Uri.parse(url))) {
  //       if (context.mounted) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Could not launch $url')),
  //         );
  //       }
  //     }
  //   } catch (e) {
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Error launching URL: $e')),
  //       );
  //     }
  //   }
  // }

  final String bio =
      "I am on a journey to become the best version of myself. Every day is a new opportunity to grow and learn. Passionate about self-improvement and helping others along the way.";

  @override
  Widget build(BuildContext context) {
    getUserDetails();
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/ProfilePageBg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.black,
                          ),
                          child: const CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Icon(Icons.person,
                                size: 50, color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, ${name.toUpperCase()}',
                              style: AppTextStyles.bold.copyWith(fontSize: 20),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Streak ',
                                  style:
                                      AppTextStyles.bold.copyWith(fontSize: 16),
                                ),
                                Text(
                                  '${count.toString()}',
                                  style: AppTextStyles.bold.copyWith(
                                    fontSize: 18,
                                    color: AppColors.darkBlueContrast,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.location_on),
                                Text(
                                  '${city.toUpperCase()}',
                                  style: AppTextStyles.bold,
                                )
                              ],
                              // children: [
                              //   GestureDetector(
                              //     onTap: () => _launchSocialMedia(
                              //       context,
                              //       'https://instagram.com',
                              //     ),
                              //     child: SvgPicture.asset(
                              //       'assets/icons/instagram.svg',
                              //     ),
                              //   ),
                              //   const SizedBox(width: 10),
                              //   GestureDetector(
                              //     onTap: () => _launchSocialMedia(
                              //       context,
                              //       'https://x.com',
                              //     ),
                              //     child: SvgPicture.asset(
                              //       'assets/icons/Twitter.svg',
                              //       colorFilter: const ColorFilter.mode(
                              //         Colors.black,
                              //         BlendMode.srcIn,
                              //       ),
                              //       height: 18,
                              //       width: 18,
                              //     ),
                              //   ),
                              //   const SizedBox(width: 10),
                              // ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Bio.',
                        style: AppTextStyles.bold.copyWith(fontSize: 20),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset('assets/icons/edit.svg'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          color: Color.fromRGBO(0, 0, 0, 0.553),
                        ),
                      ],
                    ),
                    child: Text(
                      bio,
                      style: AppTextStyles.bold.copyWith(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Badges.',
                    style: AppTextStyles.bold.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        6,
                        (index) => Container(
                          margin: const EdgeInsets.only(right: 15),
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.black,
                              width: 2,
                            ),
                            color: AppColors.grey,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/icons/badge${index + 1}.svg',
                              width: 100,
                              height: 100,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Past Events.',
                    style: AppTextStyles.bold.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  StreamBuilder<List<EventModel>>(
                    stream: EventService()
                        .getUserEvents(FirebaseAuth.instance.currentUser!.uid),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return SelectableText('Error: ${snapshot.error}');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      final events = snapshot.data ?? [];

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          final event = events[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(0, 4),
                                    blurRadius: 4,
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                  ),
                                ],
                                color: AppColors.grey,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    event.title,
                                    style: AppTextStyles.bold
                                        .copyWith(fontSize: 16),
                                  ),
                                  Container(
                                    width: 80,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: event.organizerId ==
                                              FirebaseAuth
                                                  .instance.currentUser!.uid
                                          ? AppColors.lightBlueAccent
                                          : AppColors.darkerGrey,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      event.organizerId ==
                                              FirebaseAuth
                                                  .instance.currentUser!.uid
                                          ? 'Organized'
                                          : 'Registered',
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.bold.copyWith(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EventItem {
  final String title;
  final String status;

  EventItem({required this.title, required this.status});
}
