import 'package:flutter/material.dart';
import 'package:project2/utils/text.dart';
class TopratedTV extends StatelessWidget {
  final List topratedtv;


  const TopratedTV({Key? key, required this.topratedtv}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            modified_text(text: "Trending Movies", colour: Colors.white, size: 22.0),
            SizedBox(height:10),
            Container(
              height: 270,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: topratedtv.length,
                  itemBuilder: (context, index){
                    return InkWell(
                        onTap: (){

                        },
                        child: Container(
                          width: 140,
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://image.tmdb.org/t/p/w500'+topratedtv[index]['poster_path']
                                        )
                                    )
                                ),
                              ),
                              Container(
                                child: modified_text(text: topratedtv[index]['name']!=null?topratedtv[index]['name']:'Loading..', colour: Colors.white, size: 15.0),
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
}
