import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:de_talks/colors.dart';
import 'package:de_talks/models/events.dart';
import 'package:de_talks/services/event_service.dart';
import 'package:de_talks/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Profilepage extends StatefulWidget {
  Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage>
    with SingleTickerProviderStateMixin {
  int count = 0;
  String name = '';
  String city = '';
  bool _isChecked = false;
  bool _isLoading = false;
  late AnimationController _checkController;
  late Animation<double> _checkAnimation;
  String? profileImageUrl;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _checkController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _checkAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _checkController, curve: Curves.easeInOut),
    );
    getUserDetails();
  }

  @override
  void dispose() {
    _checkController.dispose();
    super.dispose();
  }

  Future<void> _updateStreak() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    try {
      // Start the check animation
      await _checkController.forward();

      // Calculate days until next badge
      int daysUntilNextBadge = 7 - ((count + 1) % 7);
      String badgeMessage = daysUntilNextBadge == 0
          ? 'Congratulations! You earned a new badge! 🎉'
          : 'Keep going! ${daysUntilNextBadge} day${daysUntilNextBadge == 1 ? '' : 's'} until your next badge! 🏆';

      // Update the streak in Firestore
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'dayCount': count + 1,
      });

      // Show the badge progress message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              badgeMessage,
              style: const TextStyle(fontSize: 16),
            ),
            backgroundColor:
                daysUntilNextBadge == 0 ? Colors.green : AppColors.black,
            duration: const Duration(seconds: 3),
          ),
        );
      }

      // Wait for a moment to show the strikethrough
      await Future.delayed(const Duration(milliseconds: 500));

      // Reset the checkbox and get new pledge
      if (mounted) {
        setState(() {
          _isChecked = false;
          count += 1;
        });
      }
      _checkController.reset();
    } catch (e) {
      print('Error updating streak: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating streak: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> getUserDetails() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists && mounted) {
        setState(() {
          count = userDoc.data()?['dayCount'] ?? 0;
          name = userDoc.data()?['name'] ?? 'User';
          city = userDoc.data()?['city'] ?? '';
          profileImageUrl = userDoc.data()?['photoUrl'];
        });
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  Future<void> _showImagePickerModal() async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Take a photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 75,
      );

      if (image != null) {
        await _uploadImage(File(image.path));
      }
    } catch (e) {
      print('Error picking image: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error picking image')),
        );
      }
    }
  }

  Future<void> _uploadImage(File imageFile) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    try {
      setState(() => _isLoading = true);

      // Convert image file to base64
      final bytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      // Create multipart request
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('https://api.imgbb.com/1/upload'),
      );

      // Add API key and image data
      request.fields['key'] = 'ae7a83f0653ab1f0b48a82f890757514';
      request.fields['image'] = base64Image;

      // Send request
      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      final jsonData = json.decode(responseData);

      if (response.statusCode == 200) {
        final imageUrl = jsonData['data']['url'];

        // Update Firestore with new image URL
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({'photoUrl': imageUrl});

        // Update UI
        if (mounted) {
          setState(() {
            profileImageUrl = imageUrl;
            _isLoading = false;
          });
        }
      } else {
        throw Exception(
            'Failed to upload image: ${jsonData['error']['message']}');
      }
    } catch (e) {
      print('Error uploading image: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error uploading image: $e'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() => _isLoading = false);
      }
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
                        _buildProfilePicture(),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${name}',
                              style: AppTextStyles.bold.copyWith(fontSize: 20),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Streak : ',
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
                                Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: AppColors.black.withOpacity(0.6),
                                ),
                                Text(
                                  '${city.substring(0, 1).toUpperCase() + city.substring(1)}',
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
                  Text(
                    "Today's Pledge.",
                    style: AppTextStyles.bold.copyWith(
                      fontSize: 24,
                    ),
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
                    child: Row(
                      children: [
                        Expanded(
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            style: AppTextStyles.bold.copyWith(
                              fontSize: 16,
                              color: Colors.black87,
                              decoration: _isChecked
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                            child: Text(pledges[count]),
                          ),
                        ),
                        GestureDetector(
                          onTap: _isChecked ? null : _updateStreak,
                          child: AnimatedBuilder(
                            animation: _checkAnimation,
                            builder: (context, child) {
                              return Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: AppColors.black,
                                    width: 2,
                                  ),
                                ),
                                child: _isChecked || _checkAnimation.value > 0
                                    ? CustomPaint(
                                        painter: CheckmarkPainter(
                                          progress: _checkAnimation.value,
                                          color: AppColors.black,
                                        ),
                                      )
                                    : null,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Badges.',
                    style: AppTextStyles.bold.copyWith(
                      fontSize: 24,
                    ),
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
                              'assets/icons/badge${index % 6 + 1}.svg',
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
                    style: AppTextStyles.bold.copyWith(
                      fontSize: 24,
                    ),
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

                      if (events.isEmpty) {
                        return Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 150, // Reduced height
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/noEvents.png'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const Text(
                              "Your event history will appear here", // Snappier text
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.black,
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
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

  Widget _buildProfilePicture() {
    return GestureDetector(
      onTap: _showImagePickerModal,
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: profileImageUrl != null
                      ? DecorationImage(
                          image: NetworkImage(profileImageUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                  color: profileImageUrl == null ? AppColors.black : null,
                ),
                child: profileImageUrl == null
                    ? const Icon(
                        Icons.person,
                        size: 150,
                        color: Colors.white,
                      )
                    : null,
              ),
            );
          },
        );
      },
      child: Stack(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.black,
            ),
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : profileImageUrl != null
                    ? CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(profileImageUrl!),
                        backgroundColor: Colors.transparent,
                      )
                    : const CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.transparent,
                        child:
                            Icon(Icons.person, size: 50, color: Colors.white),
                      ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.black,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(
                Icons.camera_alt,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EventItem {
  final String title;
  final String status;

  EventItem({required this.title, required this.status});
}

class CheckmarkPainter extends CustomPainter {
  final double progress;
  final Color color;

  CheckmarkPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(size.width * 0.2, size.height * 0.5);
    path.lineTo(size.width * 0.45, size.height * 0.7);
    path.lineTo(size.width * 0.8, size.height * 0.3);

    final pathMetric = path.computeMetrics().first;
    final pathSegment = pathMetric.extractPath(
      0.0,
      pathMetric.length * progress,
    );

    canvas.drawPath(pathSegment, paint);
  }

  @override
  bool shouldRepaint(CheckmarkPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
