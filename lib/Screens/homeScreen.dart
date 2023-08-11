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
  final TMDB tmdb;

  const HomeScreen({Key? key, required this.tmdb}) : super(key: key);

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
  late TMDB tmdb;

  @override
  void initState(){
    super.initState();
    tmdb = widget.tmdb;
  }

  Future<void> loadmovies()async{
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
    );
  }

}
