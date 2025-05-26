// widgets/restaurant_card.dart
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String type;
  final String description;
  final double rating;
  final int price;


  const RestaurantCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.type,
    required this.description,
    required this.rating,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFE5E5E5)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              imageUrl,
              height: 170,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 16)),
                      SizedBox(height: 4),
                      Text(type,
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 11,
                              fontWeight: FontWeight.w400)),
                      SizedBox(height: 6),
                      Text(description,
                          style: TextStyle(
                              fontSize: 11,
                              color: Color(0xff3C3636),
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.green.shade800,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(rating.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12)),
                            SizedBox(width: 4),
                            Icon(Icons.star, color: Colors.white, size: 14),
                          ],
                        ),
                      ),
                      SizedBox(height: 0),
                      Text('₹$price for two', style: TextStyle(fontSize: 12)),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset('assets/images/home/restaurant/Arrow.png',
                              height: 20),
                          SizedBox(width: 4),
                          Image.asset(
                              'assets/images/home/restaurant/MaxSafety.png',
                              height: 30),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
