import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../constants/constants.dart';
import 'qr_overlay.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  MobileScannerController mobileScannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.front,
    torchEnabled: true,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Mobile Scanner')),
      body: Stack(
        children: <Widget>[
          MobileScanner(
            controller: mobileScannerController,
            // fit: BoxFit.contain,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                debugPrint('Barcode found! ${barcode.rawValue}');
              }
            },
          ),
          QRScannerOverlay(
            overlayColour: Colors.black.withAlpha(128),
          ),
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
                    color: Constants.primary.withValues(alpha: 0.13),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                    color: Colors.white,
                  ),
                ),
                //Torch Button
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Constants.primary.withValues(alpha: 0.13),
                  ),
                  child: ValueListenableBuilder<MobileScannerState>(
                    valueListenable: mobileScannerController,
                    builder: (
                      BuildContext context,
                      MobileScannerState state,
                      Widget? child,
                    ) {
                      if (!state.isInitialized || !state.isRunning) {
                        return const SizedBox.shrink();
                      }
                      switch (state.torchState) {
                        case TorchState.off:
                          return IconButton(
                            onPressed: () => mobileScannerController.toggleTorch(),
                            icon: const Icon(
                              Icons.flash_off,
                              color: Colors.white,
                            ),
                          );
                        case TorchState.on:
                          return IconButton(
                            onPressed: () => mobileScannerController.toggleTorch(),
                            icon: const Icon(
                              Icons.flash_on,
                              color: Colors.yellow,
                            ),
                          );
                        case TorchState.auto:
                          return IconButton(
                            onPressed: () => mobileScannerController.toggleTorch(),
                            icon: const Icon(
                              Icons.flash_auto,
                              color: Colors.white,
                            ),
                          );
                        case TorchState.unavailable:
                          return const Icon(
                            Icons.no_flash,
                            color: Colors.grey,
                          );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
