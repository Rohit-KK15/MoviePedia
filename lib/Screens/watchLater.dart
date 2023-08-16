import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:project2/utils/text.dart';

import '../utils/db_helper.dart';

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
    final dbHelper = DatabaseHelper();
    await dbHelper.initDatabase();
    List<Map<String, dynamic>> data = [];
    if (_selectedOption == 'All') {
      data = (await dbHelper.getAll()).cast<Map<String, dynamic>>();
    } else if (_selectedOption == 'Movies') {
      data = (await dbHelper.getMovies()).cast<Map<String, dynamic>>();
    } else if (_selectedOption == 'TV Shows') {
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
            )
          ],
        ),
      )
    );
  }
}
