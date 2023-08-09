import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:project2/Screens/search.dart';
import 'package:project2/Screens/watchLater.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../main.dart';
import '../widgets/toprated.dart';
import '../widgets/trending.dart';
import '../widgets/tv.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List trendingmovies=[];
  List topratedmovies=[];
  List tv=[];
  List topratedTv=[];
  int selectedIndex = 0;
  String page="Home";
  final List<Text> widgetOptions = [
    const Text('Home'),
    const Text('Explore'),
    const Text('Watch Later'),
  ];
  final String apiKey='398dd2815165a8a82bc1f26f61e23970';
  final String readaccesstoken='eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzOThkZDI4MTUxNjVhOGE4MmJjMWYyNmY2MWUyMzk3MCIsInN1YiI6IjYzOWYxN2RiNjg4Y2QwMDBhOWVlODkxYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.VsIgSdG7Bc-F9iWjfYKNTUJKbVebSHqklJjdlcnNjjc';


  @override
  void initState(){
    loadmovies();
    super.initState();
  }

  Future<void> loadmovies()async{
    TMDB tmdb=TMDB(ApiKeys(apiKey, readaccesstoken),
        logConfig: const ConfigLogger(
            showLogs: true,
            showErrorLogs: true
        ));
    Map trending=await tmdb.v3.trending.getTrending();
    Map topratedMovies=await tmdb.v3.movies.getTopRated();
    Map topratedtv=await tmdb.v3.tv.getTopRated();
    Map tvshows=await tmdb.v3.tv.getTopRated();
    Map details=await tmdb.v3.movies.getCredits(564);
    setState(() {
      trendingmovies=trending['results'];
      topratedmovies=topratedMovies['results'];
      tv=tvshows['results'];
      topratedTv=topratedtv['results'];
    });
    print(details);
    print(topratedmovies);
    print(tv);
    print(topratedTv);
  }
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
      body: RefreshIndicator(
        backgroundColor: Colors.black,
        color: Colors.red,
        strokeWidth: 3,
        onRefresh: () async{
          await loadmovies();
        },
        child: ListView(
          children: [
            TrendingMovies(trending: trendingmovies),
            TV(tv: tv),
            Toprated(toprated: topratedmovies),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: const Padding(
          padding: EdgeInsets.only(
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
            padding: EdgeInsets.all(16),
            color: Colors.white,
            iconSize: 30,
            tabs: [
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

          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.home),
      //         label: "Home"
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.search),
      //         label: "Search"
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.bookmark),
      //         label: "Watch Later"
      //     ),
      //   ],
      //   currentIndex: selectedIndex,
      //   fixedColor: Colors.red,
      //   onTap: onItemTapped,
      //   backgroundColor: Colors.black,
      // ),
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