import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'rooms_screen.dart';
import 'notices_screen.dart';
import 'mess_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Tracks which tab is active — 0=Home,1=Rooms,2=Notices,3=Mess,4=Profile
  int _currentIndex = 0;

  static const List<Widget> _screens = [
    HomeScreen(),
    RoomsScreen(),
    NoticesScreen(),
    MessScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index:    _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:        _currentIndex,
        
        onTap: (i) => setState(() => _currentIndex = i),
        type:                BottomNavigationBarType.fixed,
        selectedItemColor:   const Color(0xFF4F46E5),
        unselectedItemColor: const Color(0xFF9CA3AF),
        backgroundColor:     Colors.white,
        elevation:           10,
        selectedFontSize:    11,
        unselectedFontSize:  11,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_rounded),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bed_outlined),
              activeIcon: Icon(Icons.bed_rounded),
              label: 'Rooms'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_outlined),
              activeIcon: Icon(Icons.notifications_rounded),
              label: 'Notices'),
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_outlined),
              activeIcon: Icon(Icons.restaurant_rounded),
              label: 'Mess'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              activeIcon: Icon(Icons.person_rounded),
              label: 'Profile'),
        ],
      ),
    );
  }
}