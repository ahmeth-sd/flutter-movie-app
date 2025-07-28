import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shartflix_movie_app/presentation/home/view/home_page.dart';
import '../viewmodel/navigation_vievmodel.dart';
import '../widgets/custom_bottom_navbar.dart';
import 'profile_page.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navViewModel = Provider.of<NavigationViewModel>(context);
    final pages = [
      const HomePage(),
      const ProfilePage(),
    ];
    return Scaffold(
      body: pages[navViewModel.currentIndex],
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}

