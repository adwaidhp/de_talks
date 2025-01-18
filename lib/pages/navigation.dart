import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  // Function to handle navigation
  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // List of pages to navigate to
  // final List<Widget> _pages = [
  //   HomeScreen(),
  //   SupportScreen(),
  //   ProfileScreen(),
  //   UpdatesScreen(),
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // body: _pages[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 18),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
              30), // Clip the container for rounded corners
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(
                  255, 0, 0, 0), // Background color for navigation bar
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(0.5), // Shadow for the floating effect
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: GNav(
              color: const Color.fromARGB(
                  255, 96, 96, 96), // Color for inactive icons
              activeColor: Color(0xFF526732), // Color for active icons
              gap: 8, // Space between items
              padding: EdgeInsets.symmetric(
                  horizontal: 14, vertical: 16), // Button padding
              selectedIndex: _selectedIndex, // Current active index
              onTabChange: _navigateBottomBar, // Handle tab changes
              tabs: [
                GButton(
                  icon: Icons.home, // Placeholder icon
                  iconColor: Colors.transparent, // Make icon invisible
                  leading: Image.asset(
                    "assets/images/Explore.png",
                    height: 24,
                    width: 24,
                    fit: BoxFit.contain,
                  ),
                  text: 'Explore',
                  textStyle: TextStyle(color: Color(0xFF526732)), // Label color
                ),
                GButton(
                  icon: Icons.circle,
                  iconColor: Colors.transparent,
                  leading: Image.asset(
                    "assets/images/support.png",
                    height: 24,
                    width: 24,
                    fit: BoxFit.contain,
                  ),
                  text: 'Support',
                  textStyle: TextStyle(color: Color(0xFF526732)),
                ),
                GButton(
                  icon: Icons.circle,
                  iconColor: Colors.transparent,
                  leading: Image.asset(
                    "assets/images/updates.png",
                    height: 24,
                    width: 24,
                    fit: BoxFit.contain,
                  ),
                  text: 'Updates',
                  textStyle: TextStyle(color: Color(0xFF526732)),
                ),
                GButton(
                  icon: Icons.circle,
                  iconColor: Colors.transparent,
                  leading: Image.asset(
                    "assets/images/report.png",
                    height: 24,
                    width: 24,
                    fit: BoxFit.contain,
                  ),
                  text: 'Report',
                  textStyle: TextStyle(color: Color(0xFF526732)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
