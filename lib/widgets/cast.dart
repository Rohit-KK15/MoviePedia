import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmdb_api/tmdb_api.dart';

class Cast extends StatefulWidget {
  final int id;
  final bool ms;
  const Cast({Key? key, required this.id, required this.ms}) : super(key: key);

  @override
  State<Cast> createState() => _CastState(id: id, ms: ms, indx: 0);
}

class _CastState extends State<Cast> {

  List cast=[];
  List crew=[];
  final String apiKey='398dd2815165a8a82bc1f26f61e23970';
  final String readaccesstoken='eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzOThkZDI4MTUxNjVhOGE4MmJjMWYyNmY2MWUyMzk3MCIsInN1YiI6IjYzOWYxN2RiNjg4Y2QwMDBhOWVlODkxYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.VsIgSdG7Bc-F9iWjfYKNTUJKbVebSHqklJjdlcnNjjc';
  int id;
  bool ms;
  int indx;
  _CastState({Key? key, required this.id, required this.ms, required this.indx});


  @override
  void initState(){
    loadCredits();
    super.initState();
  }

  Future<void> loadCredits() async{
    TMDB tmdb=TMDB(ApiKeys(apiKey, readaccesstoken),
        logConfig: ConfigLogger(
            showLogs: true,
            showErrorLogs: true
        ));

    Map credits = ms?await tmdb.v3.movies.getCredits(id):await tmdb.v3.tv.getCredits(id);
    cast=credits['cast'];
    crew=credits['crew'];
    print(cast);
    print(crew);
    for(int i=0;i<=crew.length;i++){
      if(crew[i]['job']=='Director'){
        indx=i;
        break;
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(
        "Cast",
        style: GoogleFonts.alumniSans(
          color: Colors.white,
          fontSize: 35.0,
          fontWeight: FontWeight.bold,
        ),
      ),
          SizedBox(height:10),
          Container(
            height: 200,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cast.length,
                itemBuilder: (context, index){
                  if(cast[index]['profile_path']==null) {
                    return InkWell(
                        child: cast[index]['name'] != null ? Container(
                          padding: EdgeInsets.all(5),
                          width: 130,
                          child: Column(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'images/empty_profile.jpg'
                                      ), fit: BoxFit.fill,
                                    )
                                ),
                              ),
                              SizedBox(height: 1,),
                              Container(
                                child: Text(
                                    cast[index]['name'] != null
                                        ? cast[index]['name'] + "\n(" +
                                        cast[index]['character'] + ")"
                                        : 'Loading..',
                                    style: GoogleFonts.breeSerif(
                                        color: Colors.white,
                                        fontSize: 15.0
                                    )
                                ),
                              )
                            ],
                          ),
                        ) : Container()
                    );
                  }
                  else
                    {
                      return InkWell(
                          child: cast[index]['name'] != null ? Container(
                            padding: EdgeInsets.all(5),
                            width: 130,
                            child: Column(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'https://image.tmdb.org/t/p/w500' +
                                                cast[index]['profile_path']
                                        ), fit: BoxFit.fill,
                                      )
                                  ),
                                ),
                                SizedBox(height: 1,),
                                Container(
                                  child: Text(
                                      cast[index]['name'] != null
                                          ? cast[index]['name'] + "\n(" +
                                          cast[index]['character'] + ")"
                                          : 'Loading..',
                                      style: GoogleFonts.breeSerif(
                                          color: Colors.white,
                                          fontSize: 15.0
                                      )
                                  ),
                                )
                              ],
                            ),
                          ) : Container()
                      );
                    }
                }
            ),
          ),
          Text(
            "Crew",
            style: GoogleFonts.alumniSans(
              color: Colors.white,
              fontSize: 35.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Container(
          //   height: 100,
          //   width: 100,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(100),
          //       image: DecorationImage(
          //         image: NetworkImage(
          //             'https://image.tmdb.org/t/p/w500'+crew[indx]['profile_path']
          //         ), fit: BoxFit.fill,
          //       )
          //   ),
          // ),
          // SizedBox(height: 1,),
          // Container(
          //   child: Text(
          //       crew[indx]['name']!=null?crew[indx]['name']+"\n("+crew[indx]['job']+")":'Loading..',
          //       style: GoogleFonts.breeSerif(
          //           color: Colors.white,
          //           fontSize: 15.0
          //       )
          //   ),
          // )
          SizedBox(height:10),
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                image: DecorationImage(
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500' +
                          crew[indx]['profile_path']
                  ), fit: BoxFit.fill,
                )
            ),
          ),
          // Container(
          //   height: 200,
          //   child: ListView.builder(
          //       scrollDirection: Axis.horizontal,
          //       itemCount: crew.length,
          //       itemBuilder: (context, index){
          //         if(crew[index]['profile_path']==null) {
          //           return InkWell(
          //               child: crew[index]['name'] != null ? Container(
          //                 padding: EdgeInsets.all(5),
          //                 width: 130,
          //                 child: Column(
          //                   children: [
          //                     Container(
          //                       height: 100,
          //                       width: 100,
          //                       decoration: BoxDecoration(
          //                           borderRadius: BorderRadius.circular(100),
          //                           image: DecorationImage(
          //                             image: AssetImage(
          //                                 'images/empty_profile.jpg'
          //                             ), fit: BoxFit.cover,
          //                           )
          //                       ),
          //                     ),
          //                     SizedBox(height: 1,),
          //                     Container(
          //                       child: Text(
          //                           crew[index]['name'] != null
          //                               ? crew[index]['name'] + "\n(" +
          //                               crew[index]['job'] + ")"
          //                               : 'Loading..',
          //                           style: GoogleFonts.breeSerif(
          //                               color: Colors.white,
          //                               fontSize: 15.0
          //                           )
          //                       ),
          //                     )
          //                   ],
          //                 ),
          //               ) : Container()
          //           );
          //         }
          //         else
          //         {
          //           return InkWell(
          //               child: crew[index]['name'] != null ? Container(
          //                 padding: EdgeInsets.all(5),
          //                 width: 130,
          //                 child: Column(
          //                   children: [
          //                     Container(
          //                       height: 100,
          //                       width: 100,
          //                       decoration: BoxDecoration(
          //                           borderRadius: BorderRadius.circular(100),
          //                           image: DecorationImage(
          //                             image: NetworkImage(
          //                                 'https://image.tmdb.org/t/p/w500' +
          //                                     crew[index]['profile_path']
          //                             ), fit: BoxFit.fill,
          //                           )
          //                       ),
          //                     ),
          //                     SizedBox(height: 1,),
          //                     Container(
          //                       child: Text(
          //                           crew[index]['name'] != null
          //                               ? crew[index]['name'] + "\n(" +
          //                               crew[index]['job'] + ")"
          //                               : 'Loading..',
          //                           style: GoogleFonts.breeSerif(
          //                               color: Colors.white,
          //                               fontSize: 15.0
          //                           )
          //                       ),
          //                     )
          //                   ],
          //                 ),
          //               ) : Container()
          //           );
          //         }
          //       }
          //   ),
          // ),
        ]
      )

    );
  }

}

