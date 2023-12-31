import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:project2/utils/text.dart';

import '../utils/db_helper.dart';
import 'description.dart';

class WatchLater extends StatefulWidget {
  const WatchLater({Key? key}) : super(key: key);

  @override
  State<WatchLater> createState() => _WatchLaterState();
}

class _WatchLaterState extends State<WatchLater> {

  String _selectedOption = 'ALL';
  List<Map<String, dynamic>> _displayData = [];


  @override
  void initState() {
    super.initState();
    _fetchData();
  }


  Future<void> _fetchData() async {
    print("heyoooo");
    final dbHelper = DatabaseHelper();
    await dbHelper.initDatabase();
    List<Map<String, dynamic>> data = [];
    if (_selectedOption == 'ALL') {
      data = (await dbHelper.getAll()).cast<Map<String, dynamic>>();
    } else if (_selectedOption == 'Movies') {
      data = (await dbHelper.getMovies()).cast<Map<String, dynamic>>();
    } else if (_selectedOption == 'TVShows') {
      data = (await dbHelper.getTVShows()).cast<Map<String, dynamic>>();
    }

    setState(() {
      _displayData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(
            top: 15.0,bottom: 8.0,left: 15, right: 15
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisSize: MainAxisSize.min,
              children: [
                const modified_text(text: "WatchList", colour: Colors.red, size: 35),
                const SizedBox(width: 20.0),
                SizedBox(
                  width: 120,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: DropdownButton<String>(
                          value: _selectedOption,
                          onChanged: (String? newValue){
                            setState(() {
                              _selectedOption = newValue!;
                              _fetchData();
                            });
                          },
                        items: <String>['ALL','Movies','TVShows'].map((String value){
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                      }
                      ).toList(),
                        style: const TextStyle(fontSize: 18.0, color: Colors.white),
                        icon: const Icon(Ionicons.chevron_down_outline, color: Colors.red,),
                        iconSize: 25.0,
                        underline: Container(
                          height: 2,
                          color: Colors.transparent,
                        ),
                        dropdownColor: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(10.0),
                        elevation: 8,
                        isExpanded: true,),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20,),
            if(_displayData.isNotEmpty)...[
              Expanded(
                  child: SingleChildScrollView(
                      child: _buildDisplayRows())
              )
            ]else ...[
              const SizedBox(
                height: 400,
                child: Center(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Your WatchList is Empty 🧐 !!',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15
                        ),
                      ),
                    )
                ),
              )
            ]
          ],
        ),
      )
    );
  }

  Widget _buildDisplayRows() {
    List<Widget> rows = [];

    for (int i = 0; i < _displayData.length; i += 2) {
      List<Widget> rowChildren = [];

      for (int j = i; j < i + 2 && j < _displayData.length; j++) {
        rowChildren.add(
          InkWell(
              onTap: (){
                print(111111);
                print(jsonDecode(_displayData[j]['cast']));
                int current = j;
                int id=_displayData[j]['id'];
                Navigator.push(context,MaterialPageRoute(builder: (context)=>Description(
                  name: _displayData[j]['name'],
                  desc: _displayData[j]['desc'],
                  bannerurl: 'https://image.tmdb.org/t/p/w500'+_displayData[j]['bannerUrl'],
                  posterurl: 'https://image.tmdb.org/t/p/w500'+_displayData[j]['posterUrl'],
                  vote: _displayData[j]['vote'],
                  launch_on: _displayData[j]['launchOn'],
                  id: id,
                  ms: _displayData[j]['ms'] == 1 ? true  : false,
                  online: false,
                  cast: jsonDecode(_displayData[j]['cast']) as List<dynamic>,
                  crew: jsonDecode(_displayData[j]['crew']) as List<dynamic>,
                  // crew: loadCrew(i),
                ))).then((result) {
                  if (result != null && result is bool && result){
                    setState(() {
                      _fetchData();
                    });
                  }
                });
              },
            child: Container(
              padding: const EdgeInsets.all(18),
              height: 270,
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://image.tmdb.org/t/p/w500'+_displayData[j]['posterUrl'],
                          ),fit: BoxFit.fill
                      )
                    ),

                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    width: 100,
                    child: Center(
                      child: Text(
                        _displayData[j]['name'],
                        style: GoogleFonts.breeSerif(
                           color: Colors.white,
                           fontSize: 15.0,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }

      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: rowChildren,
        ),
      );
    }

    return Column(children: rows);
  }

}
