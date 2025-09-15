import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../home/presentation/screens/home_screen/category_list_screen.dart';
import '../../../home/presentation/screens/home_screen/home_screen.dart';
import '../../../products/wish_list.dart';
import '../controllers/main_nav_controller.dart';

class BottomNavHolderScreen extends StatefulWidget {
  static const String name = '/bottom-nav-holder';

  const BottomNavHolderScreen({super.key});

  @override
  State<BottomNavHolderScreen> createState() => _BottomNavHolderScreenState();
}

class _BottomNavHolderScreenState extends State<BottomNavHolderScreen> {


  final List<Widget> _screens = [
    HomeScreen(),
    CategoryListScreen(),
    HomeScreen(),
    wishListScreen(),

  ];


  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainNavController>(
      builder: (mainNavController) {
        return Scaffold(
          body: _screens[mainNavController.currentIndex],
          bottomNavigationBar: NavigationBar(
            selectedIndex: mainNavController.currentIndex,
            onDestinationSelected: mainNavController.changeIndex,
            destinations: [
              NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(
                icon: Icon(Icons.dashboard_customize_outlined),
                label: 'Categories',
              ),
              NavigationDestination(
                icon: Icon(Icons.shopping_cart_checkout),
                label: 'Cart',
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite_outline),
                label: 'Wishlist',
              ),
            ],
          ),
        );
      },
    );
  }
}