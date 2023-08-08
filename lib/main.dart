import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project2/Screens/search.dart';
import 'package:project2/Screens/watchLater.dart';
import 'package:project2/widgets/toprated.dart';
import 'package:project2/widgets/trending.dart';
import 'package:project2/widgets/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main()=>runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Home(),
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
  List trendingmovies=[];
  List topratedmovies=[];
  List tv=[];
  List topratedTv=[];
  int selectedIndex = 0;
  String page="Home";
  final List<Text> widgetOptions = [
    Text('Home'),
    Text('Explore'),
    Text('Watch Later'),
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

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: "Watch Later"
          ),
        ],
        currentIndex: selectedIndex,
        fixedColor: Colors.red,
        onTap: onItemTapped,
        backgroundColor: Colors.black,
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    String lbl;
    if(selectedIndex==0) {
      lbl="Home";
    } else if(selectedIndex==1) {
      lbl="Search";
    } else {
      lbl="Watch Later";
    }
    print(index);
    if(page!=lbl && index==0) {
      Navigator.push(context,MaterialPageRoute(builder: (context) =>MyApp()));
    } else if(page!=lbl && index==1) {
      Navigator.push(context,MaterialPageRoute(builder: (context) =>SearchPage()));
    } else if(page!=lbl && index==2) {
      Navigator.push(context,MaterialPageRoute(builder: (context) =>watchLater()));
    }
  }

}
