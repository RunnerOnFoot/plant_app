import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:planet_app/constants/constants.dart';
import 'package:planet_app/models/plant.dart';
import '../widgets/extension.dart';

import '../widgets/plant_widget.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<String> _plantTypes = <String>[
    'همه',
    'پیشنهادی',
    'آپارتمانی',
    'محل‌کار',
    'باغچه‌ایی',
    'سمی',
  ];

  List<Plant> filterlist = [];

  String type = '';

  @override
  void initState() {
    type = _plantTypes[1];
    super.initState();
  }

  bool toggleIsFavoriet(bool isFavoriet) {
    return !isFavoriet;
  }

  final List<Plant> _plantList = Plant.plantList;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //search Box
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: Constants.primary.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.mic,
                      color: Constants.blackColor.withOpacity(0.6),
                    ),
                    const Expanded(
                      child: TextField(
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.start,
                        showCursor: false,
                        style: TextStyle(
                          fontFamily: Constants.vazirFont,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(right: 5),
                          hintText: 'جستجو...',
                          hintTextDirection: TextDirection.rtl,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.search,
                    ),
                  ],
                ),
              ),
            ),
            //Category
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              height: 70,
              width: size.width,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                reverse: true,
                scrollDirection: Axis.horizontal,
                itemCount: _plantTypes.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          filterlist = _plantList
                              .where(
                                (Plant element) =>
                                    element.category == _plantTypes[index],
                              )
                              .toList();
                        });
                      },
                      child: Text(
                        _plantTypes[index],
                        style: TextStyle(
                          fontFamily: Constants.vazirFont,
                          fontSize: 16,
                          fontWeight: selectedIndex == index
                              ? FontWeight.bold
                              : FontWeight.w300,
                          color: selectedIndex == index
                              ? Constants.primary
                              : Constants.blackColor,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            //Product one
            filterlist.isNotEmpty
                ? SizedBox(
                    height: size.height * 0.3,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: filterlist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            PageTransition(
                              child: DetailPage(
                                  plantId: filterlist[index].plantId),
                              type: PageTransitionType.fade,
                            ),
                          ),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 18),
                            width: 200,
                            decoration: BoxDecoration(
                              color: Constants.primary.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  top: 10,
                                  right: 20,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    width: 40,
                                    height: 40,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          bool isFavorated = toggleIsFavoriet(
                                              filterlist[index].isFavorated);
                                          filterlist[index].isFavorated =
                                              isFavorated;
                                        });
                                      },
                                      icon: Icon(
                                        filterlist[index].isFavorated
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Constants.primary,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 50,
                                  right: 50,
                                  top: 50,
                                  bottom: 50,
                                  child:
                                      Image.asset(filterlist[index].imageURL),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 20,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      filterlist[index]
                                              .price
                                              .toString()
                                              .farsiNumber +
                                          r'$',
                                      style: TextStyle(
                                        color: Constants.primary,
                                        fontSize: 16,
                                        fontFamily: Constants.vazirFont,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  right: 20,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        filterlist[index].category,
                                        style: const TextStyle(
                                          fontFamily: Constants.danaFont,
                                          color: Colors.white70,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        filterlist[index].plantName,
                                        style: const TextStyle(
                                          fontFamily: Constants.vazirFont,
                                          color: Colors.white70,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : SizedBox(
                    height: size.height * 0.3,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: _plantList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            PageTransition(
                              child: DetailPage(
                                  plantId: _plantList[index].plantId),
                              type: PageTransitionType.fade,
                            ),
                          ),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 18),
                            width: 200,
                            decoration: BoxDecoration(
                              color: Constants.primary.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  top: 10,
                                  right: 20,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    width: 40,
                                    height: 40,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          bool isFavorated = toggleIsFavoriet(
                                              _plantList[index].isFavorated);
                                          _plantList[index].isFavorated =
                                              isFavorated;
                                        });
                                      },
                                      icon: Icon(
                                        _plantList[index].isFavorated
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Constants.primary,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 50,
                                  right: 50,
                                  top: 50,
                                  bottom: 50,
                                  child:
                                      Image.asset(_plantList[index].imageURL),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 20,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      _plantList[index]
                                              .price
                                              .toString()
                                              .farsiNumber +
                                          r'$',
                                      style: TextStyle(
                                        color: Constants.primary,
                                        fontSize: 16,
                                        fontFamily: Constants.vazirFont,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  right: 20,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        _plantList[index].category,
                                        style: const TextStyle(
                                          fontFamily: Constants.danaFont,
                                          color: Colors.white70,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        _plantList[index].plantName,
                                        style: const TextStyle(
                                          fontFamily: Constants.vazirFont,
                                          color: Colors.white70,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            //Text
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(
                top: 20,
                right: 18,
                bottom: 15,
              ),
              child: const Text(
                'گیاهان جدید',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: Constants.vazirFont,
                ),
              ),
            ),
            //Product two
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              height: size.height * 0.2,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return NewPlantWidget(
                    plantList: _plantList,
                    size: size,
                    index: index,
                  );
                },
                itemCount: _plantList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
