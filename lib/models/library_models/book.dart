import 'dart:convert';

class Book {
  String title;
  String author;
  String edition;
  String? description;
  Book({
    required this.title,
    required this.author,
    required this.edition,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': title,
      'author': author,
      'edition': edition,
      'description': description,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      title: map['name'] ?? '',
      author: map['author'] ?? '',
      edition: map['edition'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source));
}
