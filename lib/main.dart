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
      home: HomeScreen()
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
