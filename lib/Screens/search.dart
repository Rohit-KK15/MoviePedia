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

    // String url = '$baseUrl/search/movie?api_key=$apiKey&query=$query';

    // final response = await http.get(Uri.parse(url));

    // if (response.statusCode == 200) {
    //   final data = json.decode(response.body);
    //   setState(() {
    //     _searchResults = data['results'];
    //   });
    // } else {
    //   throw Exception('Failed to load search results');
    // }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade800, // Grey background color
                borderRadius: BorderRadius.circular(25), // Half of the height for oval effect
              ),
              child:  Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Enter text',
                      border: InputBorder.none, // Hide the default border
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final movie = _searchResults[index];
                return ListTile(
                  title: Text(movie['title']),
                  subtitle: Text(movie['overview']),
                  leading: movie['poster_path'] != null
                      ? Image.network(
                    'https://image.tmdb.org/t/p/w92${movie['poster_path']}',
                    width: 50,
                    height: 75,
                    fit: BoxFit.cover,
                  )
                      : Container(
                    width: 50,
                    height: 75,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
