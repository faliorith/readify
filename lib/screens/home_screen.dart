import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readify/bloc/book_bloc.dart';
import 'package:readify/components/book_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Readify'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Implement notifications
            },
          ),
        ],
      ),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state is BookLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (state is BookError) {
            return Center(child: Text(state.message));
          }
          
          if (state is BookLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.books.length,
              itemBuilder: (context, index) {
                final book = state.books[index];
                return BookCard(book: book);
              },
            );
          }
          
          return const Center(child: Text('Нет книг для отображения'));
        },
      ),
    );
  }
} 