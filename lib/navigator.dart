import 'package:flutter/material.dart';
import 'home.dart';
import 'ecommerce_page.dart';
import 'event.dart';
import 'loker.dart';
import 'Profile.dart';

class MainAppNavigator extends StatefulWidget {
  const MainAppNavigator({super.key});

  @override
  State<MainAppNavigator> createState() => _MainAppNavigatorState();
}

class _MainAppNavigatorState extends State<MainAppNavigator> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(), // Home
    EcommercePage(), // E-commerce
    const EventPage(), // Event
    const JobListPage(), // Loker
    const ProfilePage(), // Profile
  ];

  final List<String> _titles = [
    'Home',
    'E-commerce',
    'Event',
    'Loker',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.home, 'Home'),
              _buildNavItem(1, Icons.shopping_bag, 'E-commerce'),
              _buildNavItem(2, Icons.event, 'Event'),
              _buildNavItem(3, Icons.work, 'Loker'),
              _buildNavItem(4, Icons.person, 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: _selectedIndex == index ? const Color(0xFF004E46) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: _selectedIndex == index ? Colors.white : const Color(0xFF757575),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: _selectedIndex == index ? Colors.white : const Color(0xFF757575),
                fontWeight: _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
