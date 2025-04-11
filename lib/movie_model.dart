class Movie {
  final int? id;
  final String title;
  final String year;
  final String review;
  final double rating;

  Movie({
    this.id,
    required this.title,
    required this.year,
    required this.review,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'year': year,
      'review': review,
      'rating': rating,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      title: map['title'],
      year: map['year'],
      review: map['review'],
      rating: map['rating'],
    );
  }
}
