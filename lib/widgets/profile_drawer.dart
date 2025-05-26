import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomProfileDrawer extends StatefulWidget {
  const CustomProfileDrawer({Key? key}) : super(key: key);

  @override
  _CustomProfileDrawerState createState() => _CustomProfileDrawerState();
}

class _CustomProfileDrawerState extends State<CustomProfileDrawer> {
  bool _isDrawerOpen = false;

  @override
  void initState() {
    super.initState();

    // Automatically open drawer after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isDrawerOpen = true;
      });
    });
  }

  void toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    double drawerWidth = MediaQuery.of(context).size.width * 0.75;

    return Stack(
      children: [
        // Animated Drawer
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          left: _isDrawerOpen ? 0 : -drawerWidth,
          top: 0,
          bottom: 0,
          child: SizedBox(
            width: drawerWidth,
            child: SafeArea(
              child: Material(
                elevation: 8,
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 12.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: toggleDrawer,
                          child: Icon(HugeIcons.strokeRoundedCancelCircle,
                              size: 24),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10),
                      child: Column(
                        children: [
                          Text("My profile",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400)),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 36,
                                backgroundImage:
                                    AssetImage('assets/images/ava.png'),
                              ),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Matilda Brown',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                  Text('matildabrown@mail.com',
                                      style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Menu Items (Static)
                    Expanded(
                      child: ListView(
                        children: [
                          _buildDrawerItem(
                              title: "My orders",
                              subtitle: "Already have 12 orders"),
                          _buildDrawerItem(
                              title: "Shipping addresses",
                              subtitle: "3 addresses"),
                          _buildDrawerItem(
                              title: "Payment methods", subtitle: "Visa **34"),
                          _buildDrawerItem(
                              title: "Promocodes",
                              subtitle: "You have special promocodes"),
                          _buildDrawerItem(
                              title: "My reviews",
                              subtitle: "Reviews for 4 items"),
                          _buildDrawerItem(
                              title: "Settings",
                              subtitle: "Notifications, password"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Optional Floating button to open drawer manually
    
      
      ],
    );
  }

  Widget _buildDrawerItem({required String title, required String subtitle}) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.grey)),
      trailing:
          Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xff9B9B9B)),
      // enabled: false, 
    );
  }
}
