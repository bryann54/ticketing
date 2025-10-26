// lib/features/tickets/presentation/pages/ticket_scanning_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ticketing/common/res/colors.dart';
import 'package:ticketing/features/shows/data/models/show_model.dart';
import 'package:ticketing/features/tickets/domain/entities/ticket_entity.dart';
import 'package:ticketing/features/tickets/presentation/bloc/tickets_bloc.dart';
import 'package:ticketing/features/tickets/presentation/bloc/tickets_event.dart';
import 'package:ticketing/features/tickets/presentation/bloc/tickets_state.dart';
import 'package:ticketing/features/tickets/presentation/widgets/ticket_result_dialog.dart';

@RoutePage()
class TicketScanningScreen extends StatefulWidget {
  final ShowModel show;

  const TicketScanningScreen({
    super.key,
    required this.show,
  });

  @override
  State<TicketScanningScreen> createState() => _TicketScanningScreenState();
}

class _TicketScanningScreenState extends State<TicketScanningScreen>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late MobileScannerController _controller;
  bool _isProcessing = false;
  String? _lastScannedCode;
  late AnimationController _animationController;
  late Animation<double> _scanLineAnimation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeController();
    _initializeAnimations();
  }

  void _initializeController() {
    _controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
      torchEnabled: false,
      formats: [BarcodeFormat.qrCode],
    );
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _scanLineAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_controller.value.isInitialized) return;

    switch (state) {
      case AppLifecycleState.resumed:
        _controller.start();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        _controller.stop();
        break;
    }
  }

  void _onBarcodeDetect(BarcodeCapture capture) {
    if (_isProcessing) return;

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final String? code = barcodes.first.rawValue;
    if (code == null || code.isEmpty) return;

    // Prevent duplicate scans
    if (code == _lastScannedCode) return;

    setState(() {
      _isProcessing = true;
      _lastScannedCode = code;
    });

    final showId = widget.show.id?.toString() ?? '';
    context.read<TicketsBloc>().add(ScanTicketEvent(code, showId));
  }

  void _restartScanning() {
    setState(() {
      _isProcessing = false;
      _lastScannedCode = null;
    });
    context.read<TicketsBloc>().add(const ResetTicketStateEvent());
  }

  void _autoRestartScanning() {
    // Auto-restart after a short delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _restartScanning();
      }
    });
  }

  Future<void> _toggleTorch() async {
    await _controller.toggleTorch();
    setState(() {});
  }

  Future<void> _switchCamera() async {
    await _controller.switchCamera();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TicketsBloc, TicketsState>(
      listener: (context, state) {
        switch (state.status) {
          case TicketsStatus.scanSuccess:
            _showTicketResultDialog(context, state.currentTicket!);
            break;
          case TicketsStatus.scanError:
            // Auto-restart on error after showing error
            _autoRestartScanning();
            break;
          case TicketsStatus.initial:
            setState(() => _isProcessing = false);
            break;
          default:
            break;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: _buildScannerContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child:
                  const Icon(Icons.arrow_back, color: Colors.white, size: 20),
            ),
            onPressed: () => context.router.maybePop(),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Scan Ticket',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.show.name,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white70,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          _buildCameraControls(),
        ],
      ),
    );
  }

  Widget _buildCameraControls() {
    return ValueListenableBuilder(
      valueListenable: _controller,
      builder: (context, value, child) {
        final torchState = value.torchState;
        final isTorchAvailable = torchState != TorchState.unavailable;
        final isTorchOn = torchState == TorchState.on;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isTorchAvailable)
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isTorchOn ? Icons.flash_on : Icons.flash_off,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                onPressed: _toggleTorch,
              ),
            IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.cameraswitch,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              onPressed: _switchCamera,
            ),
          ],
        );
      },
    );
  }

  Widget _buildScannerContent() {
    return Stack(
      children: [
        _buildScanner(),
        _buildScannerOverlay(),
        _buildStatusOverlay(),
      ],
    );
  }

  Widget _buildScanner() {
    return MobileScanner(
      controller: _controller,
      onDetect: _onBarcodeDetect,
      fit: BoxFit.cover,
      errorBuilder: (context, error, child) {
        return Container(
          color: Colors.black,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.camera_alt,
                  color: Colors.white54,
                  size: 64,
                ),
                const SizedBox(height: 16),
                Text(
                  'Camera Unavailable',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    'Please check camera permissions',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white54,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => context.router.maybePop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Go Back'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildScannerOverlay() {
    return Positioned.fill(
      child: CustomPaint(
        painter: _ScannerOverlayPainter(scanLineAnimation: _scanLineAnimation),
      ),
    );
  }

  Widget _buildStatusOverlay() {
    return Positioned(
      bottom: 100,
      left: 0,
      right: 0,
      child: BlocBuilder<TicketsBloc, TicketsState>(
        builder: (context, state) {
          if (state.status == TicketsStatus.loading || _isProcessing) {
            return _buildProcessingOverlay();
          }

          if (state.status == TicketsStatus.scanError) {
            return _buildErrorOverlay(state.errorMessage);
          }

          return _buildReadyOverlay();
        },
      ),
    );
  }

  Widget _buildProcessingOverlay() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Validating ticket...',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildErrorOverlay(String? errorMessage) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.white,
                size: 32,
              ),
              const SizedBox(height: 8),
              Text(
                errorMessage ?? 'Scan failed',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Auto-restarting...',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white70,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReadyOverlay() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.qr_code_scanner,
                color: AppColors.primaryColor,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'Align QR code within frame',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Only show manual scan again if user wants to force restart
        if (_lastScannedCode != null)
          ElevatedButton.icon(
            icon: const Icon(Icons.refresh, size: 18),
            label: const Text('Scan Another'),
            onPressed: _restartScanning,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
      ],
    );
  }

  void _showTicketResultDialog(BuildContext context, TicketEntity ticket) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => TicketResultDialog(ticket: ticket),
    ).then((_) {
      // Auto-restart scanning after dialog is closed
      _autoRestartScanning();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
  }
}

class _ScannerOverlayPainter extends CustomPainter {
  final Animation<double> scanLineAnimation;

  _ScannerOverlayPainter({required this.scanLineAnimation})
      : super(repaint: scanLineAnimation);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw semi-transparent overlay
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), paint);

    // Calculate scanner frame dimensions
    final frameSize = size.width * 0.7;
    final frameLeft = (size.width - frameSize) / 2;
    final frameTop = (size.height - frameSize) / 2 - 50;
    final frameRect = Rect.fromLTWH(frameLeft, frameTop, frameSize, frameSize);

    // Clear the center for scanner
    canvas.drawRect(frameRect, Paint()..blendMode = BlendMode.clear);

    // Draw frame border
    final borderPaint = Paint()
      ..color = AppColors.primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawRect(frameRect, borderPaint);

    // Draw animated scan line
    final scanLineY = frameTop + (frameSize * scanLineAnimation.value);
    final scanLinePaint = Paint()
      ..color = AppColors.primaryColor.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTWH(frameLeft, scanLineY, frameSize, 2),
      scanLinePaint,
    );

    // Draw corner indicators
    final cornerSize = 20.0;
    final cornerPaint = Paint()
      ..color = AppColors.primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    // Top left corner
    canvas.drawLine(
      Offset(frameLeft, frameTop + cornerSize),
      Offset(frameLeft, frameTop),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(frameLeft, frameTop),
      Offset(frameLeft + cornerSize, frameTop),
      cornerPaint,
    );

    // Top right corner
    canvas.drawLine(
      Offset(frameLeft + frameSize - cornerSize, frameTop),
      Offset(frameLeft + frameSize, frameTop),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(frameLeft + frameSize, frameTop),
      Offset(frameLeft + frameSize, frameTop + cornerSize),
      cornerPaint,
    );

    // Bottom left corner
    canvas.drawLine(
      Offset(frameLeft, frameTop + frameSize - cornerSize),
      Offset(frameLeft, frameTop + frameSize),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(frameLeft, frameTop + frameSize),
      Offset(frameLeft + cornerSize, frameTop + frameSize),
      cornerPaint,
    );

    // Bottom right corner
    canvas.drawLine(
      Offset(frameLeft + frameSize - cornerSize, frameTop + frameSize),
      Offset(frameLeft + frameSize, frameTop + frameSize),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(frameLeft + frameSize, frameTop + frameSize - cornerSize),
      Offset(frameLeft + frameSize, frameTop + frameSize),
      cornerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
