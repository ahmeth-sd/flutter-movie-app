import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../viewmodel/auth_viewmodel.dart';
import '../viewmodel/profile_viewmodel.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileViewModel>().loadFavorites(refresh: true);
      context.read<AuthViewModel>().fetchUserName();
    });
  }

  void _onScroll() {
    final vm = context.read<ProfileViewModel>();
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      if (vm.hasMore && !vm.isLoadingMore) {
        vm.loadMoreFavorites();
      }
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galeriden Seç'),
                onTap: () async {
                  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _profileImage = File(pickedFile.path);
                    });
                  }
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Kamera ile Çek'),
                onTap: () async {
                  final pickedFile = await picker.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    setState(() {
                      _profileImage = File(pickedFile.path);
                    });
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.watch<ProfileViewModel>();
    final authViewModel = context.watch<AuthViewModel>();
    final isLoading = authViewModel.isUserNameLoading;
    final userName = authViewModel.userName;
    final userEmail = authViewModel.loginModel?.email ?? '-';

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.arrow_back, color: Colors.white),
                  const Text("Profil Detayı",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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

              // Kullanıcı Bilgileri
              Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : const AssetImage('assets/SinFlixSplash.png') as ImageProvider,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            isLoading ? 'Yükleniyor...' : (userName ?? 'Kullanıcı'),
                            style: const TextStyle(color: Colors.white, fontSize: 18)),
                        const SizedBox(height: 4),
                        Text(
                          userEmail,
                          style: const TextStyle(color: Colors.white54, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                    ),
                    onPressed: _pickImage,
                    child: const Text("Fotoğraf Ekle"),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              const Text("Beğendiğim Filmler",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              const SizedBox(height: 12),

              // Favori Filmler Grid
              Expanded(
                child: Stack(
                  children: [
                    GridView.builder(
                      controller: _scrollController,
                      itemCount: profileViewModel.favoriteMovies.length,
                      padding: const EdgeInsets.only(bottom: 15),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.6,
                      ),
                      itemBuilder: (context, index) {
                        final movie = profileViewModel.favoriteMovies[index];
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
                    if (profileViewModel.isLoadingMore)
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}