import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../utils/text.dart';
import 'description.dart';

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


  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];

  void _performSearch() async {
    String query = _searchController.text;

    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    try{
      Map result = await tmdb.v3.search.queryMulti(query);
      setState(() {
        _searchResults = result['results'];
      });
      print(result);
    }catch(e){
      print(e);
    }
  }

  String loadrating(@required double rate) {
    return((rate).toStringAsFixed(1));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade800, // Grey background color
                borderRadius: BorderRadius.circular(25), // Half of the height for oval effect
              ),
              child:  Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    onChanged: (value) {
                      _performSearch();
                    },
                    controller: _searchController,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: Colors.white54
                      ),
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Ionicons.search_outline,
                        color: Colors.white,
                      ) // Hide the default border
                    ),
                  ),
                ),
              ),
            ),
          ),
          if(_searchResults.isNotEmpty)...[
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  Map movie = _searchResults[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: Colors.white60
                          )
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: ListTile(
                          title: modified_text(text: movie['name'] ?? movie['title'], colour: Colors.white, size: 20.0),
                          subtitle: modified_text(text: movie['release_date'] ?? movie['first_air_date'] ?? 'N/A', colour: Colors.grey, size: 15.0),
                          leading: movie['poster_path'] != null
                              ? Image.network(
                            'https://image.tmdb.org/t/p/w92${movie['poster_path']}',
                            width: 50,
                            height: 75,
                            fit: BoxFit.cover,
                          ):
                          // Container(
                          //   width: 50,
                          //   height: 75,
                          //   color: Colors.grey,
                          // ),
                          Image.asset(
                              'assets/images/moviepedia.jpg',
                              width: 50,
                              height: 75,
                              fit: BoxFit.cover,
                          ),
                          trailing: Container(
                            width: 70,
                            height: 25,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade800,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text(
                                  movie['release_date'] != null ? '#Movie' : '#TVShow',
                                  style: const TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 13
                                  ),
                              ),
                            ),
                          ),
                          onTap: (){
                              int id = movie['id'];
                              Navigator.push(context,MaterialPageRoute(builder: (context) =>Description(
                                name: movie['release_date'] == null ? movie['name'] : movie['title'],
                                desc: movie['overview'],
                                bannerurl: movie['backdrop_path'] != null ? 'https://image.tmdb.org/t/p/w500${movie['backdrop_path']}' : 'https://image.tmdb.org/t/p/w92${movie['poster_path']}',
                                posterurl: 'https://image.tmdb.org/t/p/w500 ${movie['poster_path']}',
                                vote: loadrating(movie['vote_average']),
                                launch_on: movie['release_date'] ?? movie['first_air_date'],
                                id: id,
                                ms: movie['release_date'] != null ? true : false,
                              )));
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ]
          else ...[
            // const Text('Empty',style: TextStyle(color: Colors.white),)
          ]
        ],
      ),
    );
  }
}
