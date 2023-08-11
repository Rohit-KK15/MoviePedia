import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:project2/Screens/homeScreen.dart';
import 'package:project2/Screens/search.dart';
import 'package:project2/Screens/watchLater.dart';
import 'package:project2/widgets/toprated.dart';
import 'package:project2/widgets/trending.dart';
import 'package:project2/widgets/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: const Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        textTheme: GoogleFonts.nunitoSansTextTheme(
            Theme.of(context).textTheme
        ),
    ));
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);



  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartUp()
    );
  }
// void onItemTapped(int index) {
//   setState(() {
//     selectedIndex = index;
//   });
//   String lbl;
//   if(selectedIndex==0) {
//     lbl="Home";
//   } else if(selectedIndex==1) {
//     lbl="Search";
//   } else {
//     lbl="Watch Later";
//   }
//   print(index);
//   if(page!=lbl && index==0) {
//     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>const MyApp()));
//   } else if(page!=lbl && index==1) {
//     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>const SearchPage()));
//   } else if(page!=lbl && index==2) {
//     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>const watchLater()));
//   }
// }

}

class StartUp extends StatefulWidget {
  const StartUp({Key? key}) : super(key: key);

  @override
  State<StartUp> createState() => _StartUpState();
}

class _StartUpState extends State<StartUp> {

  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const SearchPage(),
    const WatchLater(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
              'MoviePedia 🎬',
              style: GoogleFonts.bebasNeue(
                color: Colors.red.withOpacity(0.5),
                fontSize: 29.0,
                fontWeight: FontWeight.bold,
              )
          )
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        color: Colors.black,
        child:  Padding(
          padding: const EdgeInsets.only(
              top: 10,
              left: 20,
              right: 20
          ),
          child: GNav(
            // duration: Duration(milliseconds: 1000),
            activeColor: const Color(0xffD22B2B),
            backgroundColor: Colors.black,
            gap: 8,
            // tabBackgroundColor: Color(0xffD22B2B),
            // tabBackgroundColor: Colors.grey.shade900,
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            iconSize: 30,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.search,
                text: 'Explore',
              ),
              GButton(
                  icon: Icons.bookmark,
                  text: 'WatchList'
              ),
            ],
            selectedIndex: _currentIndex,
            onTabChange: (index){
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),

    );
  }
}

