import 'dart:io';

import 'package:base_project/core/values/languages/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeScanner extends StatefulWidget {
  @override
  _QrCodeScannerState createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final GlobalKey _qrCodeBox = GlobalKey();
  Barcode? result;
  late QRViewController controller;
  double overlaySize = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  _afterLayout(_) {
    _getSizes();
  }

  _getSizes() {
    final RenderObject? renderedBox =
        _qrCodeBox.currentContext?.findRenderObject();
    final sizeOfCameraView = renderedBox?.semanticBounds;
    setState(() {
      overlaySize = sizeOfCameraView?.width ?? 0;
    });
  }

  Widget _buildCropBox() {
    return Positioned.fill(
      child: Container(
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
              Colors.black26.withOpacity(0.5), BlendMode.srcOut),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  backgroundBlendMode: BlendMode.dstOut,
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 450,
                  ),
                  margin: const EdgeInsets.only(top: 150, left: 40, right: 40),
                  child: AspectRatio(
                    key: _qrCodeBox,
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Positioned _buildBorderCropBoxDetail() {
    return Positioned.fill(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: Container(
          //     constraints: BoxConstraints(
          //       maxWidth: 450,
          //     ),
          //     margin: const EdgeInsets.only(top: 150, left: 40, right: 40),
          //     child: AspectRatio(
          //       aspectRatio: 1,
          //       child: Container(
          //         decoration: BoxDecoration(
          //           border: Border.all(width: 0.5, color: Colors.white),
          //           borderRadius: BorderRadius.circular(0),
          //         ),
          //         child: Center(),
          //         alignment: Alignment.center,
          //       ),
          //     ),
          //   ),
          // ),
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: Container(
          //     constraints: BoxConstraints(
          //       maxWidth: 452,
          //     ),
          //     margin: const EdgeInsets.only(top: 149, left: 39, right: 39),
          //     child: AspectRatio(
          //       aspectRatio: 1,
          //       child: Container(
          //         child: SvgPicture.asset(
          //           "assets/images/qr-border.svg",
          //           width: double.infinity,
          //           height: double.infinity,
          //           semanticsLabel: 'Qr Code border',
          //         ),
          //         alignment: Alignment.center,
          //       ),
          //     ),
          //   ),
          // ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    AppTranslations.qrCodeGuide,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: overlaySize + 150 + 24,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Get.back();
                          }),
                      Text(
                        AppTranslations.qrCodeScanner,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const IconButton(
                          icon: Icon(
                            Icons.help,
                            color: Colors.white,
                          ),
                          onPressed: null),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(borderColor: Colors.blue),
            ),
          ),
          // _buildCropBox(),
          _buildBorderCropBoxDetail()
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        Get.back(result: scanData.code);
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
