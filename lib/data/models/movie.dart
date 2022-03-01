// To parse this JSON data, do
//
//     final movie = movieFromJson(jsonString);

class Movie {
  Movie({
    this.items,
    this.errorMessage,
  });

  List<Item>? items;
  String? errorMessage;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        errorMessage: json["errorMessage"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "errorMessage": errorMessage,
      };
}

class Item {
  Item({
    this.id,
    this.rank,
    this.title,
    this.fullTitle,
    this.year,
    this.image,
    this.crew,
    this.imDbRating,
    this.imDbRatingCount,
  });

  String? id;
  String? rank;
  String? title;
  String? fullTitle;
  String? year;
  String? image;
  String? crew;
  String? imDbRating;
  String? imDbRatingCount;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        rank: json["rank"],
        title: json["title"],
        fullTitle: json["fullTitle"],
        year: json["year"],
        image: json["image"],
        crew: json["crew"],
        imDbRating: json["imDbRating"],
        imDbRatingCount: json["imDbRatingCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rank": rank,
        "title": title,
        "fullTitle": fullTitle,
        "year": year,
        "image": image,
        "crew": crew,
        "imDbRating": imDbRating,
        "imDbRatingCount": imDbRatingCount,
      };
}
