import 'package:flutter/material.dart';

import 'package:planet_app/constants/constants.dart';

import 'package:planet_app/models/plant.dart';
import '../widgets/plant_widget.dart';

class FavoritePage extends StatefulWidget {
  final List<Plant> favoratedList;
  const FavoritePage({
    super.key,
    required this.favoratedList,
  });

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: widget.favoratedList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 100,
                    child: Image.asset('assets/images/favorited.png'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'علاقه مندی ها خالی است',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                      fontFamily: Constants.danaFont,
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return NewPlantWidget(
                    plantList: widget.favoratedList,
                    size: size,
                    index: index,
                  );
                },
                itemCount: widget.favoratedList.length,
              ),
            ),
    );
  }
}
