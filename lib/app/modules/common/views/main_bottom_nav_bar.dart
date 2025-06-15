import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';
import 'package:expriy_deals/app/modules/home/views/home_screen.dart';
import 'package:expriy_deals/app/modules/order/views/cart_screen.dart';
import 'package:expriy_deals/app/modules/order/views/oder_screen.dart';
import 'package:expriy_deals/app/modules/product/views/search_product_screen.dart';
import 'package:expriy_deals/app/modules/profile/views/profile_screen.dart';
import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class MainButtonNavbarScreen extends StatefulWidget {
  static String routeName = '/mainbottom-nav-screen';

  const MainButtonNavbarScreen({super.key});

  @override
  State<MainButtonNavbarScreen> createState() => _MainButtonNavbarScreenState();
}

class _MainButtonNavbarScreenState extends State<MainButtonNavbarScreen> {
  int _currentPage = 0;
  late PageController _pageController;

  final List<TabData> _tabs = [
    TabData(
      iconData: Icons.home,
      title: "Home",
      tabColor: Colors.orange,
    ),
    TabData(
      iconData: Icons.shopping_cart_outlined,
      title: "Cart",
      tabColor: Colors.blue,
    ),
    TabData(
      iconData: Icons.list_alt_rounded,
      title: "List",
      tabColor: Colors.green,
    ),
    TabData(
      iconData: Icons.person_outline_outlined,
      title: "Profile",
      tabColor: Colors.purple,
    ),
  ];

  final List<Widget> _pages = [
    const HomeScreen(),
    const CartScreen(),
    const MyOrderScreen(isBack: false,),
    ProfileScreen()
  ];

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white, // background
              border: Border.all(
                color: AppColors
                    .iconButtonThemeColor, // ✅ your custom border color
                width: 1.5,
              ),
              borderRadius:
                  BorderRadius.circular(50), // matches barBorderRadius
            ),
            child: CubertoBottomBar(
              barBorderRadius: BorderRadius.circular(50),
              selectedTab: _currentPage,
              tabs: _tabs,
              tabStyle: CubertoTabStyle.styleNormal,
              inactiveIconColor: AppColors.iconButtonThemeColor,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              onTabChangedListener: (position, title, color) {
                setState(() {
                  _currentPage = position;
                  _pageController.jumpToPage(position);
                });
              },
            ),
          )),
    );
  }
}
