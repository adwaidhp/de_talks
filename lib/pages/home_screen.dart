import 'dart:async';

import 'package:de_talks/text_styles.dart';
import 'package:flutter/material.dart';
import 'dart:math' show Random, pi;
import 'package:de_talks/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoItem {
  final String thumbnail;
  final String link;
  final String title;

  const VideoItem({
    required this.thumbnail,
    required this.link,
    required this.title,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String currentQuote;
  final String username = "Alex";
  late List<VideoItem> currentVideos;
  final Random _random = Random();

  static const List<String> quotes = [
    "Stronger than yesterday, braver than ever.",
    "The only way to do great work is to love what you do.",
    "Success is not final, failure is not fatal.",
    "Believe you can and you're halfway there.",
    "Your time is limited, don't waste it living someone else's life.",
    "The future belongs to those who believe in the beauty of their dreams.",
    "It does not matter how slowly you go as long as you do not stop.",
    "Everything you've ever wanted is on the other side of fear.",
    "The only impossible journey is the one you never begin.",
    "Life is 10% what happens to you and 90% how you react to it.",
    "The way to get started is to quit talking and begin doing.",
    "Don't watch the clock; do what it does. Keep going.",
  ];

  Widget buildVideoContainer(VideoItem video, int index) {
    return GestureDetector(
      onTap: () async {
        final Uri url = Uri.parse(video.link);
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          print('Could not launch $url');
        }
        await Future.delayed(const Duration(seconds: 3));
        replaceVideo(index);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width:
                MediaQuery.of(context).size.width > 600 ? 600 : double.infinity,
            height: (MediaQuery.of(context).size.width > 600
                    ? 600
                    : MediaQuery.of(context).size.width) *
                9 /
                16,
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(video.thumbnail),
                fit: BoxFit.cover,
              ),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 4,
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0.0, 1],
                  colors: [
                    Colors.black.withOpacity(.8),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    video.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    currentQuote = getRandomQuote();
    currentVideos = getRandomVideos(3);
  }

  String getRandomQuote() {
    final random = Random();
    return quotes[random.nextInt(quotes.length)];
  }

  void refreshQuote() {
    setState(() {
      currentQuote = getRandomQuote();
    });
  }

  static const List<VideoItem> allVideos = [
    VideoItem(
      thumbnail: 'assets/images/video2.png',
      link:
          'https://www.youtube.com/watch?v=qJ-qX3yrxC0&ab_channel=NOVAPBSOfficial',
      title: 'Addiction I Full Documentary I NOVA I PBS',
    ),
    VideoItem(
      thumbnail: 'assets/images/video3.png',
      link:
          'https://www.youtube.com/watch?v=HDfSx_Q7_Yk&ab_channel=HowAddictionHappens',
      title: 'How Addiction Happens',
    ),
    VideoItem(
      thumbnail: 'assets/images/video4.png',
      link:
          'https://www.youtube.com/watch?v=J-1neoDfLzo&t=147s&ab_channel=AddictionMindset',
      title: 'Best Method To Manage Weed Withdrawal Symptoms',
    ),
    VideoItem(
      thumbnail: 'assets/images/video5.png',
      link:
          'https://www.youtube.com/watch?v=_rBPwu2uS-w&ab_channel=Kurzgesagt%E2%80%93InaNutshell',
      title: 'Smoking kills',
    ),
    VideoItem(
      thumbnail: 'assets/images/video6.png',
      link: 'https://youtu.be/FuooVrSpffk?si=Hry_pC4SsgDsSX2c',
      title: 'The Stigma of Addiction | Tony Hoffman | TEDxFresnoState',
    ),
    VideoItem(
      thumbnail: 'assets/images/video7.png',
      link: 'https://youtu.be/Wh9O3-ciOYs?si=D4cps3c-9a-2mwyr',
      title: 'Finding sobriety on a mountaintop | Scott Strode | TEDxMileHigh',
    ),
  ];

  List<VideoItem> getRandomVideos(int count) {
    final random = Random();
    final availableVideos = List<VideoItem>.from(allVideos);
    final selectedVideos = <VideoItem>[];

    for (var i = 0; i < count; i++) {
      final index = random.nextInt(availableVideos.length);
      selectedVideos.add(availableVideos[index]);
      availableVideos.removeAt(index);
    }

    return selectedVideos;
  }

  void replaceVideo(int index) {
    setState(() {
      final availableVideos =
          allVideos.where((video) => !currentVideos.contains(video)).toList();

      if (availableVideos.isNotEmpty) {
        final random = Random();
        final newVideo =
            availableVideos[random.nextInt(availableVideos.length)];
        currentVideos[index] = newVideo;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/HomePageBg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Hello ',
                          style: TextStyle(
                            fontSize: 24,
                            color: AppColors.black,
                          ),
                          textHeightBehavior: TextHeightBehavior(
                            applyHeightToFirstAscent: false,
                            applyHeightToLastDescent: false,
                          ),
                        ),
                        Text(
                          "Alex.",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: refreshQuote,
                      child: Container(
                        height: 200,
                        alignment: Alignment.center,
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            center: Alignment(_random.nextDouble() * 2 - 1,
                                _random.nextDouble() * 2 - 1),
                            radius: 1.0,
                            colors: [
                              AppColors.white.withOpacity(0.7),
                              AppColors.darkBlueContrast.withOpacity(0.9),
                            ],
                            stops: [0.0, 0.7],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                            ),
                          ],
                        ),
                        child: Text(
                          '" $currentQuote "',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bold.copyWith(
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Here are some things to inspire you.',
                            style: TextStyle(
                              fontSize: 24,
                              color: AppColors.black,
                            ),
                            textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false,
                              applyHeightToLastDescent: false,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: Column(
                              children: [
                                ...currentVideos.asMap().entries.map(
                                      (entry) => buildVideoContainer(
                                          entry.value, entry.key),
                                    ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
