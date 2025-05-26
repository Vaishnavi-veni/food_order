import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/order_bloc.dart';
import 'order_screen2.dart';

class OrderScreen1 extends StatelessWidget {
  final String name;
  final String type;
  final String location;
  final double rating;
  final String imageUrl;

  const OrderScreen1({
    super.key,
    required this.name,
    required this.type,
    required this.location,
    required this.rating,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16), // Optional padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              _buildRestaurantInfo(),
              _buildModeTimeOffers(),
              _buildDistanceCharge(),
              _buildRecommendedSection(),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => BlocProvider(
                      create: (_) => OrderBloc(),
                      child: const OrderScreen2(),
                    ),
                  );
                },
                child: _buildFoodItemsList(),
              ),
              _buildBottomOfferBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400)),
              Text(type, style: TextStyle(fontSize: 16)),
              SizedBox(height: 4),
              Text(location,
                  style: TextStyle(color: Colors.grey, fontSize: 14)),
              SizedBox(height: 8),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 45,
                width: 90,
                alignment: Alignment.centerLeft,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    bottomLeft: Radius.circular(6),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text('$rating', style: TextStyle(color: Colors.white)),
                      SizedBox(width: 4),
                      Icon(Icons.star, color: Colors.white, size: 16),
                    ]),
                    SizedBox(width: 4),
                    Text('DELIVERY',
                        style: TextStyle(color: Colors.white, fontSize: 8)),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Container(
                height: 45,
                width: 105,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    bottomLeft: Radius.circular(100),
                  ),
                ),
                child: Image.asset(
                  'assets/images/order_screen1/6_photos.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildRestaurantInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Row(
            children: [
              Image(
                image:
                    AssetImage('assets/images/home/restaurant/MaxSafety.png'),
                height: 20,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildModeTimeOffers() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _modeTile(Icons.directions_walk, "MODE", "delivery"),
          _modeTile(Icons.access_time, "TIME", "40 mins"),
          _modeTile(Icons.local_offer, "OFFERS", "view all (3)"),
        ],
      ),
    );
  }

  Widget _modeTile(IconData icon, String title, String subtitle) {
    return Column(
      children: [
        Icon(icon, size: 24),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(fontSize: 12)),
        Text(subtitle,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildDistanceCharge() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F0F0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        children: [
          Icon(Icons.delivery_dining),
          SizedBox(width: 10),
          Text('₹25 distance charge'),
        ],
      ),
    );
  }

  Widget _buildRecommendedSection() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 20, 16, 10),
      child: Text(
        'Recommended',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildFoodItemsList() {
    final items = [
      {
        'name': 'Plant Protein Bowl',
        'price': '₹220',
        'rating': 4.5,
        'count': 11,
        'desc':
            '[Veg preparation] Spring mix, plant based, organic... read more',
        'image': 'assets/images/home/food/Healthy.png'
      },
      {
        'name': 'Spring Veg Plater',
        'price': '₹350',
        'rating': 4.5,
        'count': 16,
        'desc':
            '[Veg preparation] Spring mix, plant based, organic... read more',
        'image': 'assets/images/home/food/Healthy.png'
      },
    ];

    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: items.length * 2,
      itemBuilder: (context, index) {
        final item = items[index % items.length];
        return _buildFoodItemCard(item);
      },
      separatorBuilder: (_, __) => const SizedBox(height: 16),
    );
  }

  Widget _buildFoodItemCard(Map item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.stop_circle, color: Colors.green, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item['name'], style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 4),
              Text(item['price'],
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Row(
                children: [
                  Row(
                    children: List.generate(
                      5,
                      (index) =>
                          const Icon(Icons.star, color: Colors.amber, size: 14),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text('${item['count']}'),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.red),
                    ),
                    child: const Text('Must Try',
                        style:
                            TextStyle(fontSize: 10, color: Colors.redAccent)),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(item['desc'],
                  style: const TextStyle(color: Colors.grey, fontSize: 13)),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(item['image'], width: 70, height: 70),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text('ADD +',
                  style: TextStyle(color: Colors.redAccent)),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildBottomOfferBar() {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.shade900,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              '30% OFF up to ₹75',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Use code ZOMSAFETY on orders with items worth ₹159 or more',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
