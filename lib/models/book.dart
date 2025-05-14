import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final String id;
  final String title;
  final List<String> authors;
  final String description;
  final String? thumbnail;
  final String? subtitle;
  final double? averageRating;
  final int? ratingsCount;

  const Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.description,
    this.thumbnail,
    this.subtitle,
    this.averageRating,
    this.ratingsCount, required coverUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as String,
      title: json['title'] as String,
      authors: (json['authors'] as List<dynamic>?)?.cast<String>() ?? ['Unknown'],
      description: json['description'] as String? ?? 'No description available',
      thumbnail: json['thumbnail'] as String?,
      subtitle: json['subtitle'] as String?,
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      ratingsCount: json['ratingsCount'] as int?, coverUrl: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'authors': authors,
      'description': description,
      'thumbnail': thumbnail,
      'subtitle': subtitle,
      'averageRating': averageRating,
      'ratingsCount': ratingsCount,
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        authors,
        description,
        thumbnail,
        subtitle,
        averageRating,
        ratingsCount,
      ];
}