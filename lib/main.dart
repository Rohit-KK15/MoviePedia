import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:project2/Screens/homeScreen.dart';
import 'package:project2/Screens/search.dart';
import 'package:project2/Screens/watchLater.dart';
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



  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartUp()
    );
  }
}

class StartUp extends StatefulWidget {
  const StartUp({Key? key}) : super(key: key);

  @override
  State<StartUp> createState() => _StartUpState();
}

class _StartUpState extends State<StartUp> {

  final String apiKey='398dd2815165a8a82bc1f26f61e23970';
  final String readaccesstoken='eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzOThkZDI4MTUxNjVhOGE4MmJjMWYyNmY2MWUyMzk3MCIsInN1YiI6IjYzOWYxN2RiNjg4Y2QwMDBhOWVlODkxYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.VsIgSdG7Bc-F9iWjfYKNTUJKbVebSHqklJjdlcnNjjc';
  late TMDB tmdb;
  late List<Widget> _pages;
  late List<String> pages;

  @override
  void initState(){
    initTMDB();
    super.initState();
  }

  void initTMDB(){
    tmdb = TMDB(ApiKeys(apiKey, readaccesstoken),
        logConfig: const ConfigLogger(
            showLogs: true,
            showErrorLogs: true
        ));
    MaterialApp(initialRoute: '/first', routes: {
      '/watchlater': (context) => const WatchLater(),
      '/homescreen': (context) =>  HomeScreen(tmdb: tmdb),
      '/search': (context) =>  SearchPage(tmdb: tmdb),
    });
    pages = ['/homescreen','/search','/watchlater'];
      _pages = [
      HomeScreen(tmdb: tmdb),
      SearchPage(tmdb: tmdb,),
      const WatchLater(),
    ];
  }



  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Row(
            children:[

              Container(
                height: 29,
                width: 29,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/moviepedia.jpg')
                  )
                ),
              ),
              const SizedBox(width: 10,),
              Text(
                'MoviePedia ',
                style: GoogleFonts.bebasNeue(
                  color: Colors.red.withOpacity(0.7),
                  fontSize: 29.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

            ] 
          )
      ),
      // body: Navigator.push(context, pages[_currentIndex]),
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

