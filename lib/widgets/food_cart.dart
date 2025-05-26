import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FoodCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final VoidCallback onTap;

  const FoodCard({required this.name, required this.imageUrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Image.asset(imageUrl),
            Text(name),
          ],
        ),
      ),
    );
  }
}
