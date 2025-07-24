import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/navigation_vievmodel.dart';

class CustomBottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NavigationViewModel>(context);
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      currentIndex: viewModel.currentIndex,
      onTap: viewModel.changeTab,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Anasayfa',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
    );
  }
}