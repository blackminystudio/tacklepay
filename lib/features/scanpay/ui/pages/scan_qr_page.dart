import 'package:flutter/material.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';

import '../../store/models/model_upi_data.dart';
import '../widgets/bottomsheets/bottomsheet_scan_n_pay.dart';
import '../widgets/scan_background.dart';
import '../widgets/scan_overlay_animation.dart';

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
            Container(color: Colors.black),
            if (!isScanningPaused) _buildScanner(context),
            const ScanBackground(),
            const ScanOverlayAnimation(),
          ],
        ),
      );

// Scanner Feature
  QRCodeDartScanView _buildScanner(BuildContext context) => QRCodeDartScanView(
        formats: [BarcodeFormat.qrCode],
        scanInvertedQRCode: true,
        // takePictureButtonBuilder: (context, controller, isLoading) {
        //   if (isLoading) return const CircularProgressIndicator();
        //   return ElevatedButton(
        //     onPressed: controller.takePictureAndDecode,
        //     child: const Text('Take a picture'),
        //   );
        // },
        resolutionPreset: QRCodeDartScanResolutionPreset.high,
        onCapture: (Result result) async {
          if (isScanningPaused) return;
          setState(() {
            isScanningPaused = true;
          });
          final upiData = UpiDataModel.parseUpiString(result.text);
          if (upiData == null) {
            setState(() {
              isScanningPaused = false;
            });
            return;
          }
          await showScanNPayBottomSheet(context, upiData);
          setState(() {
            isScanningPaused = false;
          });
        },
      );
}
