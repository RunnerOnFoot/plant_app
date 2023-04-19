import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../constants/constants.dart';
import 'root.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  Widget _isActive(bool active) {
    return AnimatedContainer(
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 300),
      width: active ? 20 : 8,
      height: 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: Constants.primary,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];

    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_isActive(true));
      } else {
        indicators.add(_isActive(false));
      }
    }
    return indicators;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 0, right: 10),
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    child: RootPage(
                      initialPage: 0,
                    ),
                    type: PageTransitionType.leftToRight,
                  ),
                );
              },
              child: const Text(
                'رد کردن',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17,
                  fontFamily: Constants.vazirFont,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          PageView(
            controller: pageController,
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            children: const <Widget>[
              CreatePage(
                title: Constants.titleOne,
                description: Constants.descriptionOne,
                image: 'assets/images/plant-one.png',
              ),
              CreatePage(
                title: Constants.titleTwo,
                description: Constants.descriptionTwo,
                image: 'assets/images/plant-two.png',
              ),
              CreatePage(
                title: Constants.titleThree,
                description: Constants.descriptionThree,
                image: 'assets/images/plant-three.png',
              ),
            ],
          ),
          Positioned(
            bottom: 80,
            left: 30,
            child: Row(
              children: _buildIndicator(),
            ),
          ),
          Positioned(
            bottom: 57,
            right: 30,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Constants.primary,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    if (currentIndex < 2) {
                      currentIndex += 1;
                      if (currentIndex < 3) {
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      }
                    } else {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          child: RootPage(
                            initialPage: 0,
                          ),
                          type: PageTransitionType.leftToRight,
                        ),
                      );
                    }
                  });
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CreatePage extends StatelessWidget {
  const CreatePage({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  final String title;
  final String description;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 85),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 350,
            child: Image(
              image: AssetImage(image),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: TextStyle(
              fontFamily: Constants.vazirFont,
              fontSize: 25,
              color: Constants.primary,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: Constants.danaFont,
              fontSize: 22,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
