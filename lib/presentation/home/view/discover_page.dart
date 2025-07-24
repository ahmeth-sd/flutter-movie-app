import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/movie.dart';
import '../viewmodel/home_cubit.dart';
import '../viewmodel/home_state.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final PageController _pageController = PageController();
  List<bool> liked = [];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onScroll);
    // İlk filmleri yükle (main.dart'ta da çağrılıyor, burada tekrar çağırmaya gerek yok)
  }

  void _onScroll() {
    final cubit = context.read<HomeCubit>();
    final state = cubit.state;
    if (state is HomeLoaded) {
      // Son karta gelindiyse yeni filmleri yükle
      if (_pageController.page != null &&
          _pageController.page!.round() >= state.movies.length - 1) {
        cubit.fetchMovies(loadMore: true);
      }
    }
  }

  void _toggleLike(int index) {
    setState(() {
      liked[index] = !liked[index];
    });
  }

  @override
  void dispose() {
    _pageController.removeListener(_onScroll);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoaded) {
            final movies = state.movies;
            if (liked.length != movies.length) {
              liked = List<bool>.filled(movies.length, false);
            }
            return PageView.builder(
              scrollDirection: Axis.vertical,
              controller: _pageController,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      movie.imageUrl ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 60,
                      left: 16,
                      right: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            movie.description ?? 'Açıklama yok',
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),

                    Positioned(
                      top: 450,
                      right: 20,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        child: IconButton(
                          icon: Icon(
                            liked[index] ? Icons.favorite : Icons.favorite_border,
                            color: liked[index] ? Colors.red : Colors.white,
                            size: 30,
                          ),
                          onPressed: () => _toggleLike(index),
                        ),
                      ),
                    ),



                  ],
                );
              },
            );
          } else if (state is HomeError) {
            return Center(child: Text(state.message, style: const TextStyle(color: Colors.white)));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}