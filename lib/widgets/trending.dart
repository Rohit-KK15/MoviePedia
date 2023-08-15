import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project2/Screens/description.dart';
import 'package:tmdb_api/tmdb_api.dart';
class TrendingMovies extends StatelessWidget {
  final List trending;
  final String apiKey='398dd2815165a8a82bc1f26f61e23970';
  final String readaccesstoken='eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzOThkZDI4MTUxNjVhOGE4MmJjMWYyNmY2MWUyMzk3MCIsInN1YiI6IjYzOWYxN2RiNjg4Y2QwMDBhOWVlODkxYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.VsIgSdG7Bc-F9iWjfYKNTUJKbVebSHqklJjdlcnNjjc';


  const TrendingMovies({Key? key, required this.trending}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "TRENDING MOVIES",
            style: GoogleFonts.alumniSans(
              color: const Color(0xffD22B2B),
              fontSize: 35.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height:10),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: trending.length,
                itemBuilder: (context, index){
                return InkWell(
                  onTap: (){
                    int i=trending[index]['id'];
                    Navigator.push(context,MaterialPageRoute(builder: (context) =>Description(
                        name: trending[index]['title'],
                        desc: trending[index]['overview'],
                        bannerurl: 'https://image.tmdb.org/t/p/w500'+trending[index]['backdrop_path'],
                        posterurl: 'https://image.tmdb.org/t/p/w500'+trending[index]['poster_path'],
                        vote: loadrating(trending[index]['vote_average']),
                        launch_on: trending[index]['release_date'],
                        id: i,
                        ms: true,
                        online: true,
                        // crew: loadCrew(i),
                    )));
                    print(trending[index]['credits']);
                  },
                  child:trending[index]['title']!=null? Container(
                    padding: const EdgeInsets.all(5),
                    width: 240,
                    child: Column(
                      children: [
                        Container(
                          height: 140,
                            width: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500'+trending[index]['backdrop_path']
                                  ), fit: BoxFit.cover,
                                )
                            ),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          trending[index]['title']!=null?trending[index]['title']:'Loading..',
                          style: GoogleFonts.breeSerif(
                              color: Colors.white,
                              fontSize: 15.0
                          )
                        )
                      ],
                    ),
                  ):Container()
                );
                }
            ),
          )
        ],
      )
    );
  }

  String loadrating(@required double rate) {
    return((rate).toStringAsFixed(1));
  }
   Future<List> loadCast(int id) async {
     TMDB tmdb=TMDB(ApiKeys(apiKey, readaccesstoken),
         logConfig: const ConfigLogger(
             showLogs: true,
             showErrorLogs: true
         ));

    Map castt = await tmdb.v3.movies.getCredits(id);
    List cast=[];
    cast=castt as List;
     print(cast[0]['cast']);
    return cast;
   }



}
