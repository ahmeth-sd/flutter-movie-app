import 'package:flutter/material.dart';
      import 'package:provider/provider.dart';
      import '../viewmodel/navigation_vievmodel.dart';

      class CustomBottomNavBar extends StatelessWidget {
        const CustomBottomNavBar({super.key});

        @override
        Widget build(BuildContext context) {
          final viewModel = Provider.of<NavigationViewModel>(context);

          return Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _NavButton(
                  icon: Icons.home,
                  label: 'Anasayfa',
                  isSelected: viewModel.currentIndex == 0,
                  onTap: () => viewModel.changeTab(0),
                ),
                _NavButton(
                  icon: Icons.person,
                  label: 'Profil',
                  isSelected: viewModel.currentIndex == 1,
                  onTap: () => viewModel.changeTab(1),
                ),
              ],
            ),
          );
        }
      }

      class _NavButton extends StatelessWidget {
        final IconData icon;
        final String label;
        final bool isSelected;
        final VoidCallback onTap;

        const _NavButton({
          required this.icon,
          required this.label,
          required this.isSelected,
          required this.onTap,
        });

        @override
        Widget build(BuildContext context) {
          return GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent,
                border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }