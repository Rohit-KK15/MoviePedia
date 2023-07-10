import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project2/utils/text.dart';
import 'package:tmdb_api/tmdb_api.dart';
import '../Screens/description.dart';
class Toprated extends StatelessWidget {
  final List toprated;
  final String apiKey='398dd2815165a8a82bc1f26f61e23970';
  final String readaccesstoken='eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzOThkZDI4MTUxNjVhOGE4MmJjMWYyNmY2MWUyMzk3MCIsInN1YiI6IjYzOWYxN2RiNjg4Y2QwMDBhOWVlODkxYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.VsIgSdG7Bc-F9iWjfYKNTUJKbVebSHqklJjdlcnNjjc';


  const Toprated({Key? key, required this.toprated}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            modified_text(text: "TOPRATED MOVIES", colour: Color(0xffD22B2B), size: 35.0),
            SizedBox(height:10),
            Container(
              height: 270,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: toprated.length,
                  itemBuilder: (context, index){
                    return InkWell(
                        onTap: (){
                          int i=toprated[index]['id'];
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>Description(
                              name: toprated[index]['title'],
                              desc: toprated[index]['overview'],
                              bannerurl: 'https://image.tmdb.org/t/p/w500'+toprated[index]['backdrop_path'],
                              posterurl: 'https://image.tmdb.org/t/p/w500'+toprated[index]['poster_path'],
                              vote: toprated[index]['vote_average'].toString(),
                              launch_on: toprated[index]['release_date'],
                              id: i,
                              ms: true,
                              // crew: loadCrew(i),
                          )));
                        },
                        child: Container(
                          padding: EdgeInsets.only(
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
                                            'https://image.tmdb.org/t/p/w500'+toprated[index]['poster_path']
                                        )
                                    )
                                ),
                              ),
                              Container(
                                child: Text(
                                    toprated[index]['title']!=null?toprated[index]['title']:'Loading..',
                                    style: GoogleFonts.breeSerif(
                                        color: Colors.white,
                                        fontSize: 15.0
                                    )
                                ),
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
        logConfig: ConfigLogger(
            showLogs: true,
            showErrorLogs: true
        ));
    Map castt = await tmdb.v3.movies.getCredits(id);
    List cast=[];
    cast=castt as List;
    print(cast);
    return cast;
  }

}
