import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';

// import '../features/home/ui/pages/home_page.dart';
import '../features/scanpay/store/models/model_upi_data.dart';
import '../features/scanpay/ui/widgets/bottomsheets/bottomsheet_scan_n_pay.dart';
import '../theme/theme.dart';
import '../widgets/string_constants.dart';
import 'flavors.dart';

Widget _flavorBanner({
  required Widget child,
  bool show = true,
  required ThemeData theme,
}) =>
    !show
        ? child
        : Banner(
            location: BannerLocation.topEnd,
            message: Flavors.name,
            color: Colors.amber.withAlpha(60),
            textStyle: theme.textStyle.bodyBold,
            textDirection: TextDirection.ltr,
            child: child,
          );

class TacklePay extends StatelessWidget {
  const TacklePay({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: appName,
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        home: _flavorBanner(
          theme: Theme.of(context),
          // App Entry
          child: const TestPage(),
        ),
      );
}

class TestPage extends StatelessWidget {
  const TestPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
            child: ElevatedButton(
          child: const Text('QR Scan'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const QRPage(),
              ),
            );
          },
        )),
      );
}

class QRPage extends StatefulWidget {
  const QRPage({super.key});

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  bool isScanningPaused = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            QRCodeDartScanView(
              formats: [BarcodeFormat.qrCode], // Only QR Code format,
              // heightPreview: ,
              scanInvertedQRCode: true,
              // intervalScan: const Duration(seconds:1)
              // onResultInterceptor: (old,new){
              //  do any rule to controll onCapture.
              // }
              takePictureButtonBuilder: (context, controller, isLoading) {
                // if typeScan == TypeScan.takePicture you can customize the button.
                if (isLoading) return const CircularProgressIndicator();
                return ElevatedButton(
                  onPressed: controller.takePictureAndDecode,
                  child: const Text('Take a picture'),
                );
              },
              resolutionPreset: QRCodeDartScanResolutionPreset.high,
              // formats: [ // You can restrict specific formats.
              //  BarcodeFormat.qrCode,
              //  BarcodeFormat.aztec,
              //  BarcodeFormat.dataMatrix,
              //  BarcodeFormat.pdf417,
              //  BarcodeFormat.code39,
              //  BarcodeFormat.code93,
              //  BarcodeFormat.code128,
              //  BarcodeFormat.ean8,
              //  BarcodeFormat.ean13,
              // ],
              onCapture: (Result result) async {
                if (isScanningPaused) return; // Prevent multiple scans
                setState(() {
                  isScanningPaused = true; // Pause scanning
                });
                log('Result:${result.text}');
                final upiData = UpiDataModel.parseUpiString(result.text);
                log('Result:${upiData?.payeeFirstName}');
                log('Result:${upiData?.payeeLastName}');
                log('Result:${upiData?.payeeUpiId}');
                if (upiData == null) {
                  setState(() {
                    isScanningPaused =
                        false; // Resume scanning if parsing failed
                  });
                  return;
                }
                await showScanNPayBottomSheet(context, upiData);
                // Resume scanning when the bottom sheet is dismissed
                setState(() {
                  isScanningPaused = false;
                });
                // do anything with result
                // result.text
                // result.rawBytes
                // result.resultPoints
                // result.format
                // result.numBits
                // result.resultMetadata
                // result.time
              },
            ),
            ClipPath(
              clipper: CenterHoleClipper(cutOutSize: 280), // Define cutout size
              child: Container(
                color: Colors.black.withOpacity(0.6), // Dark overlay
              ),
            ),
            const QRScannerOverlay(), // Overlay for zoom animation
          ],
        ),
      );
}

class CenterHoleClipper extends CustomClipper<Path> {
  final double cutOutSize;

  CenterHoleClipper({required this.cutOutSize});

  @override
  Path getClip(Size size) {
    final path = Path()

      // Add the full rectangle (the overlay)
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Define the center cutout rectangle
    final center = Offset(size.width / 2, size.height / 2);
    final cutOutRect = Rect.fromCenter(
      center: center,
      width: cutOutSize,
      height: cutOutSize,
    );

    // Subtract the center cutout (to make it transparent)
    path
      ..addRRect(RRect.fromRectAndRadius(cutOutRect, const Radius.circular(20)))
      ..fillType = PathFillType.evenOdd; // Make the center transparent

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class FullScreenOverlayPainter extends CustomPainter {
  final double cutOutSize;
  final Color overlayColor;
  final double cornerRadius;

  FullScreenOverlayPainter({
    required this.cutOutSize,
    required this.overlayColor,
    required this.cornerRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Paint for the semi-transparent overlay
    final overlayPaint = Paint()
      ..color = overlayColor
      ..style = PaintingStyle.fill;

    // Draw the semi-transparent background
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), overlayPaint);

    // Define the transparent cut-out rectangle
    final center = Offset(size.width / 2, size.height / 2);
    final cutOutRect = Rect.fromCenter(
      center: center,
      width: cutOutSize,
      height: cutOutSize,
    );

    // Paint for the transparent cut-out
    final clearPaint = Paint()..blendMode = BlendMode.clear;

    // Draw the transparent cut-out with rounded corners
    canvas.drawRRect(
      RRect.fromRectAndRadius(cutOutRect, Radius.circular(cornerRadius)),
      clearPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class QRScannerOverlay extends StatefulWidget {
  const QRScannerOverlay({super.key});

  @override
  State<QRScannerOverlay> createState() => _QRScannerOverlayState();
}

class _QRScannerOverlayState extends State<QRScannerOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _sizeAnimation = Tween<double>(begin: 200, end: 250).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _sizeAnimation,
        builder: (context, child) => Center(
          child: CustomPaint(
            size: Size(_sizeAnimation.value, _sizeAnimation.value),
            painter: ContinuousRoundedCornerBoxPainter(
              color: Colors.white,
              strokeWidth: 6.0,
              cornerRadius: 15.0,
              cornerLength: 40.0,
            ),
          ),
        ),
      );
}

class ContinuousRoundedCornerBoxPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double cornerRadius;
  final double cornerLength;

  ContinuousRoundedCornerBoxPainter({
    required this.color,
    required this.strokeWidth,
    required this.cornerRadius,
    required this.cornerLength,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()

      // Top-left corner
      ..moveTo(0, cornerLength)
      ..lineTo(0, cornerRadius)
      ..arcToPoint(
        Offset(cornerRadius, 0),
        radius: Radius.circular(cornerRadius),
      )
      ..lineTo(cornerLength, 0)

      // Top-right corner
      ..moveTo(size.width - cornerLength, 0)
      ..lineTo(size.width - cornerRadius, 0)
      ..arcToPoint(
        Offset(size.width, cornerRadius),
        radius: Radius.circular(cornerRadius),
      )
      ..lineTo(size.width, cornerLength)

      // Bottom-right corner
      ..moveTo(size.width, size.height - cornerLength)
      ..lineTo(size.width, size.height - cornerRadius)
      ..arcToPoint(
        Offset(size.width - cornerRadius, size.height),
        radius: Radius.circular(cornerRadius),
      )
      ..lineTo(size.width - cornerLength, size.height)

      // Bottom-left corner
      ..moveTo(cornerLength, size.height)
      ..lineTo(cornerRadius, size.height)
      ..arcToPoint(
        Offset(0, size.height - cornerRadius),
        radius: Radius.circular(cornerRadius),
      )
      ..lineTo(0, size.height - cornerLength);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
