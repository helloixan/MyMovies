import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyMovies Mobile App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'MyMovies App'),
    );
  }
}

class Movie {
  final String title;
  final String year;
  final String review;
  final double rating;

  Movie({
    required this.title,
    required this.year,
    required this.review,
    required this.rating,
  });
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Movie> _movies = [];

  void _showAddMovieDialog() {
    final titleController = TextEditingController();
    final yearController = TextEditingController();
    final reviewController = TextEditingController();
    double rating = 3.0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tambah Film'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Judul Film'),
                ),
                TextField(
                  controller: yearController,
                  decoration: const InputDecoration(labelText: 'Tahun Rilis'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: reviewController,
                  decoration: const InputDecoration(labelText: 'Ulasan'),
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                Text('Rating: ${rating.toStringAsFixed(1)}'),
                Slider(
                  value: rating,
                  min: 1.0,
                  max: 5.0,
                  divisions: 4,
                  label: rating.toStringAsFixed(1),
                  onChanged: (value) {
                    setState(() {
                      rating = value;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    yearController.text.isNotEmpty &&
                    reviewController.text.isNotEmpty) {
                  setState(() {
                    _movies.add(Movie(
                      title: titleController.text,
                      year: yearController.text,
                      review: reviewController.text,
                      rating: rating,
                    ));
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRatingStars(double rating) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 20,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _movies.isEmpty
          ? const Center(child: Text('Belum ada film ditambahkan.'))
          : ListView.builder(
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                final movie = _movies[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(movie.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tahun: ${movie.year}'),
                        Text('Ulasan: ${movie.review}'),
                        _buildRatingStars(movie.rating),
                      ],
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddMovieDialog,
        tooltip: 'Tambah Film',
        child: const Icon(Icons.add),
      ),
    );
  }
}
