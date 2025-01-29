// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:plantcare/page/home/home_page.dart';
import 'package:plantcare/page/search/search_screen.dart';
import 'package:plantcare/theme/colors.dart';
import 'package:plantcare/theme/theme.dart';

void main() {
  runApp(const PlantCare());
}

class PlantCare extends StatelessWidget {
  const PlantCare({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant Care App',
      theme: AppTheme.theme,
      home: const MainNavigation(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  // Order of screens in the BottomNavigationBar
  final List<Widget> _screens = [
    HomePage(),
    const SearchScreen(),
  ];

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      IconData iconData, String label, bool isSelected) {
    return BottomNavigationBarItem(
      icon: Column(
        children: [
          Icon(iconData),
          const SizedBox(height: 4), // Adjust the height as needed
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isSelected
                  ? AppColors.primaryColor
                  : AppColors.primaryColor.withAlpha(50),
            ),
          ),
        ],
      ),
      label: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          elevation: 0,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            _buildBottomNavigationBarItem(
                FeatherIcons.feather, 'Home', _currentIndex == 0),
            _buildBottomNavigationBarItem(
                FeatherIcons.search, 'Search', _currentIndex == 1),
          ],
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.primaryColor.withAlpha(75),
        ),
      ),
    );
  }
}
