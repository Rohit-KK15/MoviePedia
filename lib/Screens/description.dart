import 'dart:async';
import 'package:ionicons/ionicons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmdb_api/tmdb_api.dart';
 class Description extends StatefulWidget {
   String name, desc, bannerurl, posterurl, vote, launch_on;
   int id;
   bool ms;
   List cast = [0];
   List crew = [0];
   int indx = 0;
   String apiKey = '398dd2815165a8a82bc1f26f61e23970';
   String readaccesstoken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzOThkZDI4MTUxNjVhOGE4MmJjMWYyNmY2MWUyMzk3MCIsInN1YiI6IjYzOWYxN2RiNjg4Y2QwMDBhOWVlODkxYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.VsIgSdG7Bc-F9iWjfYKNTUJKbVebSHqklJjdlcnNjjc';

   Description(
       {Key? key, required this.name, required this.desc, required this.bannerurl, required this.posterurl, required this.vote, required this.launch_on, required this.id, required this.ms})
       : super(key: key);

   @override
   State<Description> createState() =>
       _DescriptionState(
         id: id,
         ms: ms,
         name: name,
         desc: desc,
         bannerurl: bannerurl,
         posterurl: posterurl,
         vote: vote,
         launch_on: launch_on
       );
 }
class _DescriptionState extends State<Description> {
  String name, desc, bannerurl, posterurl, vote, launch_on;
  int id;
  bool ms;
  List cast = [0];
  List crew = [0];
  int indx = 0;
  bool _isLoading = true;
  String apiKey = '398dd2815165a8a82bc1f26f61e23970';
  String readaccesstoken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzOThkZDI4MTUxNjVhOGE4MmJjMWYyNmY2MWUyMzk3MCIsInN1YiI6IjYzOWYxN2RiNjg4Y2QwMDBhOWVlODkxYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.VsIgSdG7Bc-F9iWjfYKNTUJKbVebSHqklJjdlcnNjjc';

  _DescriptionState(
      {Key? key, required this.name, required this.desc, required this.bannerurl, required this.posterurl, required this.vote, required this.launch_on, required this.id, required this.ms});

    void loadCredits() async{
      TMDB tmdb=TMDB(ApiKeys(apiKey, readaccesstoken),
          logConfig: const ConfigLogger(
              showLogs: true,
              showErrorLogs: true
          ));

      Map credits = ms?await tmdb.v3.movies.getCredits(id):await tmdb.v3.tv.getCredits(id);
      setState((){
        cast=credits['cast'];
        crew=credits['crew'];
        _isLoading = false;
      });
      print(cast);
      print(crew);
      for(int i=0;i<crew.length;i++){
        if(crew[i]['job']=='Director'){
          print(i);
          indx=i;
          break;
        }
      }
    }

  @override
  void initState(){
    loadCredits();
    super.initState();
  }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Colors.black,
       body: ListView(
         children: [
           SizedBox(
             height: 250,
             child: Stack(
               children: [
                 Positioned(
                     child: SizedBox(
                       height: 250,
                       width: MediaQuery.of(context).size.width,
                       child: Image.network(bannerurl, fit: BoxFit.cover,),
                     )
                 ),
                 Positioned(
                   top: 10,
                   child: IconButton(
                     icon: const Icon(
                         Ionicons.chevron_back_outline,
                         size: 35,
                     ),
                     onPressed: (){
                     Navigator.pop(context);
                     },
                   ),
                 ),
                 Positioned(
                   bottom: 10,
                     child: Padding(
                       padding: const EdgeInsets.only(
                         left: 8.0,
                       ),
                       child: Container(
                         decoration: BoxDecoration(
                           color: Colors.black.withOpacity(0.5),
                           borderRadius: BorderRadius.circular(10)
                         ),
                           child: Padding(
                             padding: const EdgeInsets.symmetric(
                               vertical: 5,
                               horizontal: 10,
                             ),
                             child: Text(
                                 '⭐ $vote',
                                 style: GoogleFonts.robotoCondensed(
                                     color: Colors.white,
                                     fontSize: 25.0,
                                   fontWeight: FontWeight.bold,
                                 ),
                             ),
                           )
                       ),
                     )
                 )
               ],
             )
           ),
           const SizedBox(height: 15),
           Container(
             padding: const EdgeInsets.only(
                 right:10,
               left:10,
               bottom:10,
             ),
             child: Text(
               name,
               style: GoogleFonts.alumniSans(
                 color: const Color(0xffD22B2B),
                 fontSize: 40.0,
                 fontWeight: FontWeight.bold,
               ),
             ),
           ),
           Container(
             padding: const EdgeInsets.only(left:10),
             child: Text(
               '(Release Date: $launch_on)',
               style: const TextStyle(
                 color: Colors.yellow,
                 fontFamily: 'Bebas Neue',
                 fontSize: 15.0,
                 fontWeight: FontWeight.bold,
               ),
             ),
           ),
           Padding(
             padding: const EdgeInsets.only(
                 top:50.0,
                 left:10,
               right:10
             ),
             child: Container(
               decoration: BoxDecoration(
                 color: Colors.grey.withOpacity(0.5),
                 borderRadius: BorderRadius.circular(20),
               ),
               child: Padding(
                 padding: const EdgeInsets.symmetric(
                   vertical: 15,
                   horizontal: 15,
                 ),
                 child: Text(
                     desc,
                     style: const TextStyle(
                         color: Colors.white,
                         fontSize: 18,
                     )
                 ),
             ),
             ),
           ),
           Padding(
             padding:const EdgeInsets.only(
                 top:10.0,
                 left:10,
                 right:10
             ),
             child: Container(
               decoration: BoxDecoration(
                 color: Colors.black.withOpacity(0.5),
                 borderRadius: BorderRadius.circular(20),
               ),
               child: Container(
                   padding: const EdgeInsets.all(10.0),
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
                         const SizedBox(height:10),
                   if (_isLoading) ...[
                 const CircularProgressIndicator(),
               ] else ...[
                         SizedBox(
                           height: 220,
                           child: ListView.builder(
                               scrollDirection: Axis.horizontal,
                               itemCount: cast.length,
                               itemBuilder: (context, index){
                                 if(cast[index]['profile_path']==null) {

                                   return InkWell(
                                       child: cast[index]['name'] != null ? Container(
                                         padding: const EdgeInsets.all(5),
                                         width: 130,
                                         child: Column(
                                           children: [
                                             Container(
                                               height: 100,
                                               width: 100,
                                               decoration: BoxDecoration(
                                                   borderRadius: BorderRadius.circular(100),
                                                   image: const DecorationImage(
                                                     image: AssetImage(
                                                         'assets/images/empty_profile.jpg'
                                                     ), fit: BoxFit.fill,
                                                   )
                                               ),
                                             ),
                                             const SizedBox(height: 1,),
                                             Text(
                                                 cast[index]['name'] != null
                                                     ? cast[index]['name'] + "\n(" +
                                                     cast[index]['character'] + ")"
                                                     : 'Loading..',
                                                 style: GoogleFonts.breeSerif(
                                                     color: Colors.white,
                                                     fontSize: 15.0
                                                 )
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
                                         padding: const EdgeInsets.all(5),
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
                                                       ),fit: BoxFit.fill)
                                               )

                                                   // image: DecorationImage(
                                                   //       image: NetworkImage(
                                                   //       'https://image.tmdb.org/t/p/w500' +
                                                   //              cast[index]['profile_path']
                                                   //   ),fit: BoxFit.fill):
                                                   //   // image: cast[index]['profile_path'] != null? NetworkImage(
                                                   //   //     'https://image.tmdb.org/t/p/w500' +
                                                   //   //         cast[index]['profile_path']):
                                                   //   // // ),fit: BoxFit.fill :
                                                   //   //  AssetImage(
                                                   //   //     'images/empty_profile.jpg'
                                                   //   // ), fit: BoxFit.fill,
                                                   // )
                                               // ),
                                             ),
                                             const SizedBox(height: 1,),
                                             Text(
                                                 cast[index]['name'] != null
                                                     ? cast[index]['name'] + "\n(" +
                                                     cast[index]['character'] + ")"
                                                     : 'Loading..',
                                                 style: GoogleFonts.breeSerif(
                                                     color: Colors.white,
                                                     fontSize: 15.0
                                                 )
                                             )
                                           ],
                                         ),
                                       ) : Container()
                                   );
                                 }
                               }
                           ),
                         ),],
                         Text(
                           "Crew",
                           style: GoogleFonts.alumniSans(
                             color: Colors.white,
                             fontSize: 35.0,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                           if (_isLoading) ...[
     const CircularProgressIndicator(),
     ] else ...[
                         SizedBox(
                           height: 220,
                           child: ListView.builder(
                               scrollDirection: Axis.horizontal,
                               itemCount: crew.length,
                               itemBuilder: (context, index){
                                 if(crew[index]['profile_path']==null) {
                                   return InkWell(
                                       child: crew[index]['name'] != null ? Container(
                                         padding: const EdgeInsets.all(5),
                                         width: 130,
                                         child: Column(
                                           children: [
                                             Container(
                                               height: 100,
                                               width: 100,
                                               decoration: BoxDecoration(
                                                   borderRadius: BorderRadius.circular(100),
                                                   image: const DecorationImage(
                                                     image: AssetImage(
                                                         '../assets/images/empty_profile.jpg'
                                                     ), fit: BoxFit.cover,
                                                   )
                                               ),
                                             ),
                                             const SizedBox(height: 1,),
                                             Text(
                                                 crew[index]['name'] != null
                                                     ? crew[index]['name'] + "\n(" +
                                                     crew[index]['job'] + ")"
                                                     : 'Loading..',
                                                 style: GoogleFonts.breeSerif(
                                                     color: Colors.white,
                                                     fontSize: 15.0
                                                 )
                                             )
                                           ],
                                         ),
                                       ) : Container()
                                   );
                                 }
                                 else
                                 {
                                   return InkWell(
                                       child: crew[index]['name'] != null ? Container(
                                         padding: const EdgeInsets.all(5),
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
                                                             crew[index]['profile_path']
                                                     ), fit: BoxFit.fill,
                                                   )
                                               ),
                                             ),
                                             const SizedBox(height: 1,),
                                             Text(
                                                 crew[index]['name'] != null
                                                     ? crew[index]['name'] + "\n(" +
                                                     crew[index]['job'] + ")"
                                                     : 'Loading..',
                                                 style: GoogleFonts.breeSerif(
                                                     color: Colors.white,
                                                     fontSize: 15.0
                                                 )
                                             )
                                           ],
                                         ),
                                       ) : Container(
                                       )
                                   );
                                 }
                               }
                           ),
                         ),],
                       ]
                   )

               )
             ),
           )
         ],
       ),
     );
   }
 }
 