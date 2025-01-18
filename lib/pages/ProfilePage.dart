import 'package:de_talks/colors.dart';
import 'package:de_talks/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({super.key});

  final String bio =
      "I am on a journey to become the best version of myself. Every day is a new opportunity to grow and learn. Passionate about self-improvement and helping others along the way.";

  @override
  Widget build(BuildContext context) {
    const int count = 30;
    const name = "Alex Sanders";
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
                            gradient: LinearGradient(
                              colors: [
                                AppColors.darkBlueContrast,
                                AppColors.lightBlueAccent
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
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
                              name,
                              style: AppTextStyles.bold.copyWith(fontSize: 20),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Day ',
                                  style:
                                      AppTextStyles.bold.copyWith(fontSize: 16),
                                ),
                                Text(
                                  '$count',
                                  style: AppTextStyles.bold.copyWith(
                                    fontSize: 18,
                                    color: AppColors.darkBlueContrast,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset('assets/icons/instagram.svg'),
                                const SizedBox(width: 10),
                                SvgPicture.asset(
                                  'assets/icons/twitter.svg',
                                  width: 10,
                                  height: 10,
                                ),
                                const SizedBox(width: 10),
                              ],
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
                        'Bio',
                        style: AppTextStyles.bold.copyWith(fontSize: 20),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Add edit functionality here
                        },
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
                    'Badges',
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
                    'Past Events',
                    style: AppTextStyles.bold.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Creating Future',
                              style: AppTextStyles.bold.copyWith(fontSize: 16),
                            ),
                            Container(
                              width: 80,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.darkerGrey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Attended',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.bold.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Hope and Healing',
                              style: AppTextStyles.bold.copyWith(fontSize: 16),
                            ),
                            Container(
                              width: 80,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.lightBlueAccent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Organised',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.bold.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}
