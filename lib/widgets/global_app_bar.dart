import 'package:e_commerce/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onProfileTap;

  const GlobalAppBar({required this.onProfileTap});

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + 20); // add extra space

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 16.0), // top padding to create space above app bar
      child: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onProfileTap,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/ava.png'),
              ),
            ),
            Text(
              'Orders',
              style: AppTextStyles.title,
            ),
          ],
        ),
      ),
    );
  }
}
