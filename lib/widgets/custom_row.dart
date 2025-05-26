import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
         Container(
            height: 40,
            // width: 10,
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFE5E5E5), width: 1),
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
            ),
            child: const Center(
              child: Text(
                'Max\nSafety',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
        Container(
            height: 40,
            // width: 29,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFE5E5E5), width: 1),
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/home/pro.png', height: 15),
                const SizedBox(height: 4),
                const Text(' PRO', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
         Container(
            height: 40,
            // width: 29,
            margin: const EdgeInsets.only(left: 8),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFE5E5E5), width: 1),
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Cuisines', style: TextStyle(fontSize: 12)),
                SizedBox(width: 4),
                Icon(Icons.arrow_drop_down, size: 18)
              ],
            ),
          ),
      ],
    );
  }
}
