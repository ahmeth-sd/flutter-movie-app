import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shartflix_movie_app/presentation/home/view/login_page.dart';
import 'package:shartflix_movie_app/presentation/home/view/splash_screen.dart';
import 'package:shartflix_movie_app/presentation/home/viewmodel/auth_viewmodel.dart';
import 'package:shartflix_movie_app/presentation/home/viewmodel/login_viewmodel.dart';
import 'package:shartflix_movie_app/presentation/home/viewmodel/navigation_vievmodel.dart';
import 'package:shartflix_movie_app/presentation/home/viewmodel/profile_viewmodel.dart';
import 'package:shartflix_movie_app/data/storage/favorites_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'data/services/auth_service.dart';
import 'data/repositories/movie_repository.dart';
import 'presentation/home/viewmodel/home_cubit.dart';
import 'data/models/movie_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Hive başlatma ve favorites kutusunu açma
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(MovieModelAdapter());
  await Hive.openBox<MovieModel>('favorites');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => AuthService()),
        Provider(create: (_) => Dio()),
        Provider(create: (context) => MovieRepository(context.read<Dio>())),
        BlocProvider(create: (context) => HomeCubit(context.read<MovieRepository>())),
        ChangeNotifierProvider(create: (context) => AuthViewModel(context.read<AuthService>())),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(
          create: (_) => ProfileViewModel(FavoritesStorage()),
        ),
        ChangeNotifierProvider(create: (_) => NavigationViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: const SplashScreen(),
      ),
    );
  }
}