import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

class SearchPage extends StatefulWidget {
  final TMDB tmdb;

  const SearchPage({Key? key, required this.tmdb}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int selectedIndex = 1;
  String page="Search";
  late TMDB tmdb;

  @override
  void initState(){
    super.initState();
    tmdb = widget.tmdb;
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Text("Search"),
      // body: Column(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: TextField(
      //         controller: _searchController,
      //         onChanged: (value) {
      //           _performSearch();
      //         },
      //         decoration: InputDecoration(
      //           labelText: 'Search Movies',
      //           prefixIcon: Icon(Icons.search),
      //         ),
      //       ),
      //     ),
      //     Expanded(
      //       child: ListView.builder(
      //         itemCount: _searchResults.length,
      //         itemBuilder: (context, index) {
      //           final movie = _searchResults[index];
      //           return ListTile(
      //             title: Text(movie['title']),
      //             subtitle: Text(movie['overview']),
      //             leading: movie['poster_path'] != null
      //                 ? Image.network(
      //               'https://image.tmdb.org/t/p/w92${movie['poster_path']}',
      //               width: 50,
      //               height: 75,
      //               fit: BoxFit.cover,
      //             )
      //                 : Container(
      //               width: 50,
      //               height: 75,
      //               color: Colors.grey,
      //             ),
      //           );
      //         },
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
