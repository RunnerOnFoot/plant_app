import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:page_transition/page_transition.dart';
import 'package:planet_app/screens/camera_page.dart';

import '../constants/constants.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  MobileScannerController mobileScannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.front,
    torchEnabled: true,
  );
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //X button
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Constants.primary.withOpacity(0.13),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                      color: Constants.primary,
                    ),
                  ),
                  //Share Button
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Constants.primary.withOpacity(0.13),
                    ),
                    child: Icon(
                      Icons.share,
                      color: Constants.primary,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: size.width * 0.5,
              left: 50,
              right: 50,
              child: SizedBox(
                width: size.width * 0.8,
                height: size.width * 0.8,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: const CameraPage(),
                                  type: PageTransitionType.fade));
                        },
                        child: Image.asset(
                          'assets/images/code-scan.png',
                          height: 100,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'برای اسکن گیاهان،‌‌‌‌‌‌‌‌‌کلیک کنید ',
                        style: TextStyle(
                          color: Constants.primary.withOpacity(0.8),
                          fontFamily: Constants.vazirFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
