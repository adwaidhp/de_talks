import 'package:de_talks/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  // Define the specific blue color
  final Color activeBlue = Color(0xFF2DB3F6);

  final List<Widget> _pages = [
    HomePage(),
    Scaffold(body: Center(child: Text('Support'))),
    Scaffold(body: Center(child: Text('Profile'))),
    Scaffold(body: Center(child: Text('Updates'))),
  ];

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildSvgIcon(String path, bool isSelected) {
    return SvgPicture.asset(
      path,
      height: 24,
      width: 24,
      colorFilter: ColorFilter.mode(
        isSelected
            ? activeBlue // Active icon color - Blue
            : Colors.grey[400]!, // Inactive icon color
        BlendMode.srcIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 14, vertical: 18),
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
          child: Container(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: GNav(
                backgroundColor: Colors.transparent,
                color: Colors.grey[400]!, // Inactive color
                activeColor: activeBlue, // Active color - Blue
                tabBackgroundColor:
                    Colors.grey[900]!, // Selected tab background
                gap: 8,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                selectedIndex: _selectedIndex,
                onTabChange: _navigateBottomBar,
                tabs: [
                  _buildNavItem('Home', 'assets/icons/Home.svg', 0),
                  _buildNavItem('Support', 'assets/icons/Support.svg', 1),
                  _buildNavItem('Profile', 'assets/icons/Profile.svg', 2),
                  _buildNavItem('Updates', 'assets/icons/Updates.svg', 3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  GButton _buildNavItem(String label, String iconPath, int index) {
    bool isSelected = _selectedIndex == index;
    return GButton(
      icon: Icons.circle,
      iconColor: Colors.transparent,
      leading: _buildSvgIcon(iconPath, isSelected),
      text: label,
      textStyle: TextStyle(
        color: activeBlue, // Text color - Blue
        fontSize: 14,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      backgroundColor:
          Colors.grey[900]!.withOpacity(0.3), // Background when selected
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: EdgeInsets.symmetric(horizontal: 4),
      borderRadius: BorderRadius.circular(20),
    );
  }
}
