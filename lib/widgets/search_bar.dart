import 'package:flutter/material.dart';
import '../styles/app_text_styles.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;

  const SearchBarWidget({Key? key, required this.controller, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 2),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: const InputDecoration(
          hintText: 'Restaurant name, cuisine, or a dish...',
          border: InputBorder.none,
          icon: Icon(
            Icons.search,
            size: 25,
            color: Color.fromARGB(255, 241, 112, 112),
          ),
          hintStyle: TextStyle(color: Color(0xffC4C4C4)),
        ),
      ),
    );
  }
}