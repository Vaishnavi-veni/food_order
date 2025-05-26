import 'package:flutter/material.dart';
import '../blocs/food_bloc.dart';
import '../blocs/food_event.dart';
import '../blocs/food_state.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/custom_row.dart';
import '../widgets/food_cart.dart';
import '../widgets/profile_drawer.dart';
import '../widgets/global_app_bar.dart';
import '../widgets/restaurant.dart';
import '../widgets/search_bar.dart';
import '../models/food_item.dart';
import '../storage/shared_prefs.dart';
import '../styles/app_text_styles.dart';
import 'order_screen1.dart';
import '../models/orders.dart';
import 'package:flutter_bloc/flutter_bloc.dart';  // Adjust the path based on your folder structure


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool seeMore = false;
  int _selectedIndex = 0;

  List<FoodItem> items = [
    FoodItem(
        id: 1,
        name: 'Healthy',
        imageUrl: 'assets/images/home/food/Healthy.png'),
    FoodItem(
        id: 2,
        name: 'Biryani',
        imageUrl: 'assets/images/home/food/Biryani.png'),
    FoodItem(
        id: 3, name: 'Pizza', imageUrl: 'assets/images/home/food/Pizza.png'),
    FoodItem(
        id: 4, name: 'Haleem', imageUrl: 'assets/images/home/food/Haleem.png'),
    FoodItem(
        id: 5,
        name: 'Chicken',
        imageUrl: 'assets/images/home/food/Chicken.png'),
    FoodItem(
        id: 6, name: 'Burger', imageUrl: 'assets/images/home/food/Burger.png'),
    FoodItem(id: 7, name: 'Cake', imageUrl: 'assets/images/home/food/Cake.png'),
    FoodItem(
        id: 8,
        name: 'Shawarma',
        imageUrl: 'assets/images/home/food/Shawarma.png'),
  ];
  List<String> orderHistory = [];
  TextEditingController searchController = TextEditingController();

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
      // Optional: Handle screen switching here
    });
  }

  @override
  void initState() {
    super.initState();
    loadOrders();
      context.read<FoodBloc>().add(SearchFoodEvent('')); // initial load

  }

  Future<void> loadOrders() async {
    List<Order> orders = await SharedPrefs.getOrders();
    setState(() {
      orderHistory = orders.cast<String>();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<FoodItem> filteredItems = items
        .where((item) => item.name
            .toLowerCase()
            .contains(searchController.text.toLowerCase()))
        .toList();
    List<FoodItem> displayedItems =
        seeMore ? filteredItems : filteredItems.take(4).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Builder(
          builder: (context) => GlobalAppBar(
            onProfileTap: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: CustomProfileDrawer(),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTap,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             SearchBarWidget(
  controller: searchController,
  onChanged: (value) =>
      context.read<FoodBloc>().add(SearchFoodEvent(value)),
),

              SizedBox(height: 20),
              CustomRow(),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Image.asset('assets/images/home/Offer.png'),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Image.asset('assets/images/home/Discounts.png'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Text('Eat what makes you happy', style: AppTextStyles.title),
              SizedBox(height: 10),
                         BlocBuilder<FoodBloc, FoodState>(
  builder: (context, state) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: displayedItems.length,
      itemBuilder: (context, index) {
        final item = displayedItems[index];
        return FoodCard(
          name: item.name,
          imageUrl: item.imageUrl,
          onTap: () {},
        );
      },
    );
  },
),

              SizedBox(height: 20),
              Container(
                height: 30,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFE5E5E5), width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      seeMore = !seeMore;
                    });
                  },
                  child: Text(
                    seeMore ? 'See Less' : 'See More',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text('396 restaurants around you', style: AppTextStyles.title),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const OrderScreen1(
                              name: 'Eat Healthy',
                              type: 'Healthy food, South Indian',
                              location: 'Kukatpally, Hyderabad',
                              rating: 4.3,
                              imageUrl:
                                  'assets/images/home/restaurant/food1.png',
                            )),
                  );
                },
                child: RestaurantCard(
                  imageUrl: 'assets/images/home/restaurant/food1.png',
                  name: 'Eat Healthy',
                  type: 'Healthy food',
                  description:
                      'Zomato funds environmental projects to offset delivery carbon footprint',
                  rating: 4.3,
                  price: 300,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const OrderScreen1(
                              name: 'Amul',
                              type: 'Desserts, Ice Cream, Beverages',
                              location: 'Dwaraka, Delhi',
                              rating: 4.2,
                              imageUrl:
                                  'assets/images/home/restaurant/food1.png',
                            )),
                  );
                },
                child: RestaurantCard(
                  imageUrl: 'assets/images/home/restaurant/food2.png',
                  name: 'Amul',
                  type: 'Desserts, Ice Cream, Beverages',
                  description:
                      'Zomato funds environmental projects to offset delivery carbon footprint',
                  rating: 4.2,
                  price: 150,
                ),
              ),
              Text('Your Orders', style: AppTextStyles.title),
              ...orderHistory
                  .map((order) => ListTile(title: Text(order)))
                  .toList(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
