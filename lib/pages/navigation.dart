import 'package:de_talks/colors.dart';
import 'package:de_talks/pages/ProfilePage.dart';
import 'package:de_talks/pages/events.dart';
import 'package:de_talks/pages/home_screen.dart';
import 'package:de_talks/pages/supportpage.dart';
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
  int _previousIndex = 0;
  final Color activeBlue = AppColors.darkBlueContrast;

  final List<Widget> _pages = [
    HomePage(),
    SupportPage(),
    EventsPage(),
    Profilepage(),
  ];

  void _navigateBottomBar(int index) {
    setState(() {
      _previousIndex = _selectedIndex;
      _selectedIndex = index;
    });
  }

  Widget _buildSvgIcon(String path, bool isSelected) {
    return SvgPicture.asset(
      path,
      height: 24,
      width: 24,
      colorFilter: ColorFilter.mode(
        isSelected ? activeBlue : activeBlue,
        BlendMode.srcIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (Widget child, Animation<double> animation) {
            // Determine slide direction based on index change
            final bool slidingForward = _selectedIndex > _previousIndex;

            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(slidingForward ? 1.0 : -1.0, 0.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                // Using cubic bezier for smoother animation
                curve: const Cubic(0.2, 0.0, 0.2, 1.0),
              )),
              child: FadeTransition(
                opacity: Tween<double>(
                  begin: 0.0,
                  end: 1.0,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOut,
                )),
                child: child,
              ),
            );
          },
          layoutBuilder: (currentChild, previousChildren) {
            return Stack(
              children: <Widget>[
                ...previousChildren,
                if (currentChild != null) currentChild,
              ],
            );
          },
          child: KeyedSubtree(
            key: ValueKey<int>(_selectedIndex),
            child: _pages[_selectedIndex],
          ),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 28),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: AppColors.blackOverlay,
                blurRadius: 4,
                offset: Offset(5, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              color: AppColors.grey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                child: GNav(
                  backgroundColor: Colors.transparent,
                  color: Colors.grey[400]!,
                  activeColor: activeBlue,
                  tabBackgroundColor: Colors.grey[900]!,
                  gap: 8,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  selectedIndex: _selectedIndex,
                  onTabChange: _navigateBottomBar,
                  tabs: [
                    _buildNavItem('Home', 'assets/icons/Home.svg', 0),
                    _buildNavItem('Support', 'assets/icons/Support.svg', 1),
                    _buildNavItem('Updates', 'assets/icons/Bell.svg', 2),
                    _buildNavItem('Profile', 'assets/icons/Profile.svg', 3),
                  ],
                ),
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
      iconColor: Colors.black,
      leading: _buildSvgIcon(iconPath, isSelected),
      text: label,
      textStyle: TextStyle(
        color: activeBlue,
        fontSize: 14,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      backgroundColor: AppColors.black,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: EdgeInsets.symmetric(horizontal: 4),
      borderRadius: BorderRadius.circular(20),
    );
  }
}
