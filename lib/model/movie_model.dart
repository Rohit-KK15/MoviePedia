class Movie {
  int id;
  String name;
  String desc;
  String bannerUrl;
  String posterUrl;
  String vote;
  String launchOn;
  List<dynamic> cast;
  List<dynamic> crew;
  int ms;

  Movie({
    required this.id,
    required this.name,
    required this.desc,
    required this.bannerUrl,
    required this.posterUrl,
    required this.vote,
    required this.launchOn,
    required this.cast,
    required this.crew,
    required this.ms,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'bannerUrl': bannerUrl,
      'posterUrl': posterUrl,
      'vote': vote,
      'launchOn': launchOn,
      'cast': cast != null ? cast.join(',') : null,
      'crew': crew != null ? crew.join(',') : null,
      'ms': ms,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      name: map['name'],
      desc: map['desc'],
      bannerUrl: map['bannerUrl'],
      posterUrl: map['posterUrl'],
      vote: map['vote'],
      launchOn: map['launchOn'],
      cast: map['cast'] != null ? map['cast'].split(',') : null,
      crew: map['crew'] != null ? map['crew'].split(',') : null,
      ms: map['ms'],
    );
  }
}