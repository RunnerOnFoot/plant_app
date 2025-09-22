import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'package:planet_app/models/plant.dart';
import 'scan_page.dart';
import 'home_page.dart';
import 'profile.dart';
import 'cart_page.dart';
import 'favorite_page.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:page_transition/page_transition.dart';

class RootPage extends StatefulWidget {
  RootPage({
    Key? key,
    required this.initialPage,
  });

  final int initialPage;

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  List<Plant> favorites = [];
  List<Plant> myCart = [];

  late int _currentIndex;

  List<Widget> pages() {
    return [
      const HomePage(),
      FavoritePage(favoratedList: favorites),
      CartPage(addedToCartPlants: myCart),
      const ProfilePage(),
    ];
  }

  List<IconData> iconList = const <IconData>[
    Icons.home,
    Icons.favorite,
    Icons.shopping_cart,
    Icons.person,
  ];

  List<String> appBarTitle = const <String>[
    'خانه',
    'علاقه‌مندی‌ها',
    'سبد‌خرید',
    'پروفایل',
  ];

  @override
  void initState() {
    _currentIndex = widget.initialPage;
    setState(() {
      final List<Plant> favoritedsPlant = Plant.getFavoritedPlants();
      final List<Plant> addToCartPlant = Plant.addedToCartPlants();

      favorites = favoritedsPlant.toSet().toList();
      myCart = addToCartPlant.toSet().toList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 2
          ? null
          : AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      Icons.notifications,
                      color: Constants.blackColor,
                      size: 30,
                    ),
                    Text(
                      appBarTitle[_currentIndex],
                      style: TextStyle(
                        color: Constants.blackColor,
                        fontFamily: Constants.vazirFont,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
      body: IndexedStack(
        index: _currentIndex,
        children: pages(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              child: const ScanPage(),
              type: PageTransitionType.bottomToTop,
            ),
          );
        },
        backgroundColor: Constants.primary,
        child: const Image(
          image: AssetImage('assets/images/code-scan-two.png'),
          height: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        splashColor: Constants.primary,
        activeColor: Constants.primary,
        inactiveColor: Colors.black.withOpacity(0.5),
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.smoothEdge,
        icons: iconList,
        activeIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            final List<Plant> favoritedsPlant = Plant.getFavoritedPlants();
            final List<Plant> addToCartPlant = Plant.addedToCartPlants();

            favorites = favoritedsPlant.toSet().toList();
            myCart = addToCartPlant.toSet().toList();
          });
        },
      ),
    );
  }
}
