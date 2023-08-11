import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project2/Screens/watchLater.dart';

import '../main.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int selectedIndex = 1;
  String page="Search";
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text(
        'Search'
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
      Navigator.push(context,MaterialPageRoute(builder: (context) =>const MyApp()));
    } else if(page!=lbl && index==1) {
      Navigator.push(context,MaterialPageRoute(builder: (context) =>const SearchPage()));
    } else if(page!=lbl && index==2) {
      Navigator.push(context,MaterialPageRoute(builder: (context) =>const WatchLater()));
    }
  }
}
