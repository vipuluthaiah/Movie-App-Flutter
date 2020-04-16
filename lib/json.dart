


class Post {
  String title;
  String year;
  String rated;
  String released;
  String runtime;
  String genre;
  String director;
  String writer;
  String actors;
  String plot;
  String language;
  String country;
  String awards;
  String poster;
  String metascore;
  String imdbRating;
  String imdbVotes;
  String imdbID;
  String type;
  String response;
  List<String> images;


  Post(
      {this.title,
      this.year,
      this.rated,
      this.released,
      this.runtime,
      this.genre,
      this.director,
      this.writer,
      this.actors,
      this.plot,
      this.language,
      this.country,
      this.awards,
      this.poster,
      this.metascore,
      this.imdbRating,
      this.imdbVotes,
      this.imdbID,
      this.type,
      this.response,
      this.images
      });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'],
      year: json['year'],
      rated: json['rated'],
      actors: json['actors'],
      released: json['released'],
      runtime: json['runtime'],
      genre: json['genre'],
      director: json['director'],
      writer: json['writer'],
      plot: json['plot'],
      language: json['language'],
      country: json['country'],
      awards: json['awards'],
      poster: json['poster'],
      metascore: json['metascore'],
      imdbRating: json['imdbRating'],
      imdbVotes: json['imdbVotes'],
      imdbID: json['imdbID'],
      type: json['type'],
      response: json['response'],
      images: json['images'],
    );
  }
}

class PostList {
  final List<Post> moviepost;

  PostList({this.moviepost});

  factory PostList.fromJson(List<dynamic> parsedJson) {
    List<Post> moviepost = new List<Post>();
    moviepost = parsedJson.map((i) => Post.fromJson(i)).toList();

    return new PostList(moviepost: moviepost);
  }
}

