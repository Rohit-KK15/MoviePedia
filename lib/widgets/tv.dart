import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project2/utils/text.dart';
import 'package:tmdb_api/tmdb_api.dart';
import '../Screens/description.dart';
class TV extends StatelessWidget {
  final List tv;
  final String apiKey='398dd2815165a8a82bc1f26f61e23970';
  final String readaccesstoken='eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzOThkZDI4MTUxNjVhOGE4MmJjMWYyNmY2MWUyMzk3MCIsInN1YiI6IjYzOWYxN2RiNjg4Y2QwMDBhOWVlODkxYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.VsIgSdG7Bc-F9iWjfYKNTUJKbVebSHqklJjdlcnNjjc';

  const TV({Key? key, required this.tv}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const modified_text(text: "POPULAR TV SHOWS", colour: Color(0xffD22B2B), size: 35.0),
            const SizedBox(height:10),
            SizedBox(
              height: 270,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tv.length,
                  itemBuilder: (context, index){
                    return InkWell(
                        onTap: (){
                          int i=tv[index]['id'];
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>Description(
                              name: tv[index]['name'],
                              desc: tv[index]['overview'],
                              bannerurl: 'https://image.tmdb.org/t/p/w500'+tv[index]['backdrop_path'],
                              posterurl: 'https://image.tmdb.org/t/p/w500'+tv[index]['poster_path'],
                              vote: tv[index]['vote_average'].toString(),
                              launch_on: tv[index]['first_air_date'],
                              id: i,
                              ms: false,
                              online: true,
                              cast: const [],
                              crew: const [],
                              // crew: loadCrew(i),
                          )));
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                            right: 10,
                          ),
                          width: 140,
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://image.tmdb.org/t/p/w500'+tv[index]['poster_path']
                                        )
                                    )
                                ),
                              ),
                              Text(
                                  tv[index]['name'] ?? 'Loading..',
                                  style: GoogleFonts.breeSerif(
                                      color: Colors.white,
                                      fontSize: 15.0
                                  )
                              )
                            ],
                          ),
                        )
                    );
                  }
              ),
            )
          ],
        )
    );
  }
  Future<List> loadCast(int id) async{
    TMDB tmdb=TMDB(ApiKeys(apiKey, readaccesstoken),
        logConfig: const ConfigLogger(
            showLogs: true,
            showErrorLogs: true
        ));
    Map castt = await tmdb.v3.tv.getCredits(id);
    List cast=[];
    cast=castt as List;
    print(cast);
    return cast;
  }
  }


