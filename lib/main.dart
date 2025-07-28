import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shartflix_movie_app/presentation/home/view/login_page.dart';
import 'package:shartflix_movie_app/presentation/home/view/splash_screen.dart';
import 'package:shartflix_movie_app/presentation/home/viewmodel/auth_viewmodel.dart';
import 'package:shartflix_movie_app/presentation/home/viewmodel/login_viewmodel.dart';
import 'package:shartflix_movie_app/presentation/home/viewmodel/navigation_vievmodel.dart';
import 'package:shartflix_movie_app/presentation/home/viewmodel/profile_viewmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'data/datasources/movie_remote_datasource.dart';
import 'data/datasources/favorite_movie_remote_datasource.dart';
import 'data/services/auth_service.dart';
import 'data/repositories/movie_repository.dart';
import 'presentation/home/viewmodel/home_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    return MultiProvider(
      providers: [
        Provider<AuthService>.value(value: authService),
        Provider<http.Client>(create: (_) => http.Client()),
        Provider(
          create: (context) => MovieRepository(
            authService: context.read<AuthService>(),
            client: context.read<http.Client>(),
            remoteDataSource: MovieRemoteDataSourceImpl(client: context.read<http.Client>()),
            secureStorage: FlutterSecureStorage(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileViewModel(
            remoteDataSource: FavoriteMovieRemoteDataSourceImpl(client: context.read<http.Client>()),
            secureStorage: FlutterSecureStorage(),
          ),
        ),
        BlocProvider(create: (context) => HomeCubit(context.read<MovieRepository>())),
        ChangeNotifierProvider(create: (context) => AuthViewModel(context.read<AuthService>())),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
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