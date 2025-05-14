import 'package:flutter/material.dart';

class BookDetailsScreen extends StatelessWidget {
  final String bookId;
  const BookDetailsScreen({super.key, required this.bookId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Детали книги')),
      body: Center(child: Text('Детали книги: ID = $bookId')),
    );
  }
} 