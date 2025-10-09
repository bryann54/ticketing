// lib/features/tickets/presentation/widgets/ticket_scanner.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ticketing/common/utils/permission_utils.dart';
import 'package:ticketing/features/tickets/presentation/bloc/tickets_bloc.dart';
import 'package:ticketing/features/tickets/presentation/bloc/tickets_event.dart';
import 'package:ticketing/features/tickets/presentation/bloc/tickets_state.dart';

class TicketScanner extends StatefulWidget {
  final String showId; // Add showId parameter

  const TicketScanner({
    super.key,
    required this.showId, // Require showId
  });

  @override
  State<TicketScanner> createState() => _TicketScannerState();
}

class _TicketScannerState extends State<TicketScanner> {
  MobileScannerController cameraController = MobileScannerController();
  bool _hasPermission = false;
  bool _isCheckingPermission = true;

  @override
  void initState() {
    super.initState();
    _checkCameraPermission();
  }

  Future<void> _checkCameraPermission() async {
    final hasPermission = await PermissionUtils.hasCameraPermission();
    setState(() {
      _hasPermission = hasPermission;
      _isCheckingPermission = false;
    });
  }

  Future<void> _requestCameraPermission() async {
    final granted = await PermissionUtils.requestCameraPermission();
    setState(() {
      _hasPermission = granted;
    });
  }

  void _onBarcodeDetected(BarcodeCapture capture) {
    final barcodes = capture.barcodes;

    for (final barcode in barcodes) {
      if (barcode.rawValue != null) {
        final qrCodeData = barcode.rawValue!;
        print('QR Code detected: $qrCodeData');

        // Stop the scanner to prevent multiple scans
        cameraController.stop();

        // Send the QR code data and showId to the bloc
        context.read<TicketsBloc>().add(
              ScanTicketEvent(
                qrCodeData,
                widget.showId, // Use the passed showId
              ),
            );

        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isCheckingPermission) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (!_hasPermission) {
      return _buildPermissionDeniedView();
    }

    return _buildScannerView();
  }

  Widget _buildPermissionDeniedView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.camera_alt_outlined,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              'Camera Permission Required',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'This app needs camera access to scan QR codes from tickets.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _requestCameraPermission,
              child: const Text('Grant Camera Permission'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: PermissionUtils.openAppSettings,
              child: const Text('Open Settings'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScannerView() {
    return Stack(
      children: [
        MobileScanner(
          controller: cameraController,
          onDetect: _onBarcodeDetected,
          fit: BoxFit.cover,
        ),

        // Scanner overlay
        _buildScannerOverlay(),

        // Close button
        Positioned(
          top: MediaQuery.of(context).padding.top + 16,
          right: 16,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),

        // Loading indicator when scanning
        BlocBuilder<TicketsBloc, TicketsState>(
          builder: (context, state) {
            if (state.status == TicketsStatus.loading) {
              return Container(
                color: Colors.black.withValues(alpha: 0.7),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text(
                        'Processing ticket...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _buildScannerOverlay() {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        Colors.black.withValues(alpha: 0.5),
        BlendMode.srcOut,
      ),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              backgroundBlendMode: BlendMode.dstOut,
            ),
          ),
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
