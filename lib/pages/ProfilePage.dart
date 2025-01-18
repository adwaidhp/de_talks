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

  final List<String> pledges = [
    "Walk for 20 minutes.",
    "Write down 5 reasons you're proud of yourself.",
    "Perform 3 sets of 10 push-ups, 15 squats, and a 30-second plank.",
    "Practice 10 minutes of deep breathing.",
    "Take a 30-minute walk in nature.",
    "Write down 3 things you're grateful for.",
    "Share a positive thought with someone supportive.",
    "Do a 10-minute gentle yoga session.",
    "Spend 20 minutes decluttering a small space.",
    "Try a circuit of 10 lunges, 10 push-ups, and 15 jumping jacks.",
    "Journal for 10 minutes about your feelings.",
    "Listen to calming music for 15 minutes.",
    "Spend 30 minutes doing an activity you enjoy.",
    "Meditate for 10 minutes.",
    "Cook and eat a healthy meal.",
    "Compliment yourself out loud.",
    "Walk or jog 3 kilometers at your own pace.",
    "Watch an uplifting video or read an inspiring story.",
    "Do a 15-minute stretching routine.",
    "Reflect on 3 small wins from your week.",
    "Practice a guided body scan meditation.",
    "Spend 1 hour screen-free before bed.",
    "Write a letter to your future self about your goals.",
    "Take a mindful walk, focusing on your surroundings.",
    "Try 3 new yoga poses and hold each for a minute.",
    "Draw, paint, or create something for 20 minutes.",
    "Share one positive thing from your day with a loved one.",
    "Perform a 2-minute wall sit.",
    "Read a chapter of an inspiring book.",
    "Write down 3 affirmations and repeat them to yourself.",
    "Plan your meals for the next day.",
    "Take 10 deep breaths when you wake up.",
    "Stand outside and take in the sunrise or sunset.",
    "Spend 15 minutes in nature observing the details.",
    "Reflect on a challenging moment and how you overcame it.",
    "Do 50 jumping jacks.",
    "Spend 15 minutes organizing something small, like a drawer.",
    "Stretch your body for 5 minutes before bed.",
    "Write down one positive memory from your past.",
    "Do a 5-minute gratitude meditation."
  ];

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
                        "Today's Pledge.",
                        style: AppTextStyles.bold.copyWith(fontSize: 20),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() async {
                            count++;
                            SnackBar(
                                content: Text(
                                    '${7 - (count % 7)} days to acheive next badge!! '));
                            final userId =
                                FirebaseAuth.instance.currentUser?.uid;
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(userId)
                                .update({'dayCount': count});
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.darkerGrey),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Text("Completed", style: AppTextStyles.bold),
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
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
                      pledges[count],
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
                        (count / 7).floor() + 1,
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
                        return Text('Error: ${snapshot.error}');
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
