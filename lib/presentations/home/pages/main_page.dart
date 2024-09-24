import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_seller_app/presentations/home/pages/dashboard_page.dart';
import 'package:flutter_ecommerce_seller_app/presentations/home/pages/profile_page.dart';

import '../../../core/assets/assets.dart';
import '../../../core/core.dart';
import 'product_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const DashboardPage(),
    const ProductPage(),
    // const OrderListPage(),
    // const ProfilePage(),
    const Center(child: Text('Order List Page')),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Assets.icons.home.svg(
              colorFilter: ColorFilter.mode(
                _selectedIndex == 0 ? AppColors.primary : AppColors.gray,
                BlendMode.srcIn,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.product.svg(
              colorFilter: ColorFilter.mode(
                _selectedIndex == 1 ? AppColors.primary : AppColors.gray,
                BlendMode.srcIn,
              ),
            ),
            label: 'Product',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.order.svg(
              colorFilter: ColorFilter.mode(
                _selectedIndex == 2 ? AppColors.primary : AppColors.gray,
                BlendMode.srcIn,
              ),
            ),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.profile.svg(
              colorFilter: ColorFilter.mode(
                _selectedIndex == 3 ? AppColors.primary : AppColors.gray,
                BlendMode.srcIn,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
