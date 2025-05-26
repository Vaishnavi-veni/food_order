import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white, // Customize as needed
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Colors.black, // Customize as needed
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      items:  [
        BottomNavigationBarItem(
          icon: Icon(HugeIcons.strokeRoundedShoppingBag01),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(HugeIcons.strokeRoundedServingFood),
          label: 'Orders',
        ),
        BottomNavigationBarItem(
          icon: Icon(HugeIcons.strokeRoundedCrown),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(HugeIcons.strokeRoundedShoppingCartFavorite01),
          label: 'Profile',
        ),
      ],
    );
  }
}
