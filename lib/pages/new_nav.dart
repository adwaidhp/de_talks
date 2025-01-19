import 'package:de_talks/colors.dart';
import 'package:de_talks/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Nav extends StatefulWidget {
  const Nav({super.key});

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomePage(),
    Scaffold(body: Center(child: Text('Support'))),
    Scaffold(body: Center(child: Text('Updates'))),
    Scaffold(body: Center(child: Text('Profile'))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: GNav(
              backgroundColor: Colors.black,
              color: Colors.black.withOpacity(0.7),
              activeColor: AppColors.darkBlueContrast,
              tabBackgroundColor: AppColors.lightBlueAccent,
              gap: 8,
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              selectedIndex: _selectedIndex,
              onTabChange: _navigateBottomBar,
              tabs: [
                GButton(
                  icon: Icons.circle,
                  iconColor: Colors.transparent,
                  leading: Image.asset(
                    "assets/png_icons/Home.png",
                    height: 24,
                    width: 24,
                    color: _selectedIndex == 0
                        ? AppColors.darkBlueContrast
                        : Colors.black.withOpacity(0.7),
                  ),
                  text: 'Home',
                  textStyle: TextStyle(
                    color: AppColors.darkBlueContrast,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                GButton(
                  icon: Icons.circle,
                  iconColor: Colors.transparent,
                  leading: Image.asset(
                    "assets/png_icons/Support.png",
                    height: 24,
                    width: 24,
                    color: _selectedIndex == 1
                        ? AppColors.darkBlueContrast
                        : Colors.black.withOpacity(0.7),
                  ),
                  text: 'Support',
                  textStyle: TextStyle(
                    color: AppColors.darkBlueContrast,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                GButton(
                  icon: Icons.circle,
                  iconColor: Colors.transparent,
                  leading: Image.asset(
                    "assets/png_icons/Updates.png",
                    height: 24,
                    width: 24,
                    color: _selectedIndex == 3
                        ? AppColors.darkBlueContrast
                        : Colors.black.withOpacity(0.7),
                  ),
                  text: 'Updates',
                  textStyle: TextStyle(
                    color: AppColors.darkBlueContrast,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                GButton(
                  icon: Icons.circle,
                  iconColor: Colors.transparent,
                  leading: Image.asset(
                    "assets/png_icons/Profile.png",
                    height: 24,
                    width: 24,
                    color: _selectedIndex == 2
                        ? AppColors.darkBlueContrast
                        : Colors.black.withOpacity(0.7),
                  ),
                  text: 'Profile',
                  textStyle: TextStyle(
                    color: AppColors.darkBlueContrast,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
