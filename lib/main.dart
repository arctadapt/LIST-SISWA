import "package:flutter/material.dart";
import "package:list_siswa/view/history_view.dart";
import "package:list_siswa/view/home_view.dart";
import "package:list_siswa/view/profile_view.dart";

void main() => runApp(const Home());

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "LIST SISWA",
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;
  final tabs = [
    const HomeView(),
    const HistoryView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: const Text(
          "LIST SISWA", 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
        ), 
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 160, 235),
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: 
      BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            activeIcon: Icon(Icons.home, color: Colors.blue,),
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history), 
            label: 'History',
            activeIcon: Icon(Icons.history, color: Colors.blue,), 
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person), 
            label: 'Profile',
            activeIcon: Icon(Icons.person, color: Colors.blue,), 
            ),
        ],
      ),
    );
  }
}