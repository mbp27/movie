import 'package:flutter/material.dart';
import 'package:movie/presentation/screens/movie/movie_screen.dart';
import 'package:movie/presentation/screens/profile/profile_screen.dart';
import 'package:movie/presentation/screens/television/television_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String routeName = '/';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController _pageController;
  int _selectedPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: const [
          MovieScreen(),
          TelevisionScreen(),
          ProfileScreen(),
        ],
        onPageChanged: (value) {
          setState(() {
            _selectedPage = value;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.movie),
            icon: Icon(Icons.movie_outlined),
            label: MovieScreen.title,
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.tv),
            icon: Icon(Icons.tv),
            label: TelevisionScreen.title,
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: ProfileScreen.title,
          ),
        ],
        onTap: (int index) {
          _pageController.jumpToPage(index);
        },
        currentIndex: _selectedPage,
      ),
    );
  }
}
