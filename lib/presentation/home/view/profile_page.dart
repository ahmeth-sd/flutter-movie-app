import 'package:flutter/material.dart';
import '../../../domain/entities/movie.dart';

class ProfilePage extends StatelessWidget {
  final List<Movie> favoriteMovies;

  const ProfilePage({super.key, required this.favoriteMovies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔙 Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.arrow_back, color: Colors.white),
                  const Text("Profil Detayı",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text("Sınırlı Teklif",
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  )
                ],
              ),
              const SizedBox(height: 24),

              // 👤 Kullanıcı Bilgileri
              Row(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?img=32', // demo profil resmi
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Ayça Aydoğan",
                            style: TextStyle(color: Colors.white, fontSize: 18)),
                        SizedBox(height: 4),
                        Text("ID: 245677",
                            style: TextStyle(
                                color: Colors.white54, fontSize: 14)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                    ),
                    onPressed: () {},
                    child: const Text("Fotoğraf Ekle"),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              const Text("Beğendiğim Filmler",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              const SizedBox(height: 12),

              // 🎞 Favori Filmler Grid
              Expanded(
                child: GridView.builder(
                  itemCount: favoriteMovies.length,
                  padding: const EdgeInsets.only(bottom: 15),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.6,
                  ),
                  itemBuilder: (context, index) {
                    final movie = favoriteMovies.reversed.toList()[index];
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            color: Colors.white10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Poster
                                SizedBox(
                                  height: constraints.maxHeight * 0.75,
                                  width: double.infinity,
                                  child: movie.imageUrl != null
                                      ? Image.network(movie.imageUrl!, fit: BoxFit.cover)
                                      : const SizedBox(),
                                ),

                                // Başlık ve açıklama
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                  child: Text(
                                    movie.title,
                                    style: const TextStyle(color: Colors.white, fontSize: 16),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    movie.description ?? 'Bilinmiyor',
                                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

