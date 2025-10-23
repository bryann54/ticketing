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
    with WidgetsBindingObserver {
  late MobileScannerController _controller;
  bool _isProcessing = false;
  String? _lastScannedCode;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeController();
  }

  void _initializeController() {
    _controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
      torchEnabled: false,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Handle app lifecycle to properly manage camera
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
        if (state.status == TicketsStatus.scanSuccess) {
          _showTicketResultDialog(context, state.currentTicket!);
        } else if (state.status == TicketsStatus.scanError) {
          // Reset processing flag on error
          setState(() => _isProcessing = false);
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            _buildAppBar(),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildTitle(),
                  const SizedBox(height: 20),
                  _buildScanner(),
                  const SizedBox(height: 20),
                  _buildStatusSection(),
                  const SizedBox(height: 20),
                  _buildControlIndicators(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 120.0,
      floating: false,
      pinned: true,
      stretch: true,
      backgroundColor: AppColors.primaryColor,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        onPressed: () => context.router.maybePop(),
      ),
      actions: [
        ValueListenableBuilder(
          valueListenable: _controller,
          builder: (context, value, child) {
            final torchState = value.torchState;
            final isAvailable = torchState != TorchState.unavailable;
            final isOn = torchState == TorchState.on;

            return IconButton(
              icon: Icon(
                isOn ? Icons.flash_on : Icons.flash_off,
                color: isAvailable ? Colors.white : Colors.white54,
              ),
              onPressed: isAvailable ? _toggleTorch : null,
            );
          },
        ),
        ValueListenableBuilder(
          valueListenable: _controller,
          builder: (context, value, child) {
            final facing = value.cameraDirection;
            return IconButton(
              icon: Icon(
                facing == CameraFacing.front
                    ? Icons.camera_front
                    : Icons.camera_rear,
                color: Colors.white,
              ),
              onPressed: _switchCamera,
            );
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(
          'Scan Ticket',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryColor,
                AppColors.primaryColor.withOpacity(0.8),
                Colors.blue.shade700,
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: -30,
                right: -30,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
              Positioned(
                bottom: -20,
                left: -20,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Scan QR Code for ${widget.show.name}',
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildScanner() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.black.withOpacity(0.05),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              MobileScanner(
                controller: _controller,
                onDetect: _onBarcodeDetect,
                errorBuilder: (context, error, child) {
                  return Container(
                    color: Colors.black,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.white,
                            size: 48,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Camera Error',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Text(
                              error.errorCode.name,
                              style: const TextStyle(color: Colors.white70),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              _buildScannerOverlay(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusSection() {
    return BlocBuilder<TicketsBloc, TicketsState>(
      builder: (context, state) {
        if (state.status == TicketsStatus.loading || _isProcessing) {
          return const Column(
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Validating ticket...'),
            ],
          );
        }

        if (state.status == TicketsStatus.scanError) {
          return Column(
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 48,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  state.errorMessage ?? 'Scan failed',
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
                onPressed: _restartScanning,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          );
        }

        return ElevatedButton.icon(
          icon: const Icon(Icons.qr_code_scanner),
          label: const Text('Scan Again'),
          onPressed: _isProcessing ? null : _restartScanning,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        );
      },
    );
  }

  Widget _buildControlIndicators() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ValueListenableBuilder(
        valueListenable: _controller,
        builder: (context, value, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatusIndicator(
                'Torch',
                value.torchState == TorchState.on,
                Icons.flash_on,
              ),
              _buildStatusIndicator(
                'Camera',
                value.cameraDirection,
                Icons.camera,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildScannerOverlay() {
    return Positioned.fill(
      child: CustomPaint(
        painter: _ScannerOverlayPainter(),
        child: Center(
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primaryColor,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: _buildCornerIndicator(true, true),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: _buildCornerIndicator(false, true),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: _buildCornerIndicator(true, false),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: _buildCornerIndicator(false, false),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCornerIndicator(bool isLeft, bool isTop) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: AppColors.primaryColor,
            width: isLeft ? 8 : 0,
          ),
          top: BorderSide(
            color: AppColors.primaryColor,
            width: isTop ? 8 : 0,
          ),
          right: BorderSide(
            color: AppColors.primaryColor,
            width: !isLeft ? 8 : 0,
          ),
          bottom: BorderSide(
            color: AppColors.primaryColor,
            width: !isTop ? 8 : 0,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(
    String label,
    dynamic state,
    IconData icon,
  ) {
    Color iconColor = Colors.grey;

    if (state is bool) {
      iconColor = state ? Colors.yellow : Colors.grey;
    } else if (state is CameraFacing) {
      iconColor = Colors.white;
    }

    return Column(
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
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
      _restartScanning();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }
}

class _ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), paint);

    const centerWidth = 250.0;
    const centerHeight = 250.0;
    final centerLeft = (size.width - centerWidth) / 2;
    final centerTop = (size.height - centerHeight) / 2;

    final centerRect =
        Rect.fromLTWH(centerLeft, centerTop, centerWidth, centerHeight);
    canvas.drawRect(centerRect, Paint()..blendMode = BlendMode.clear);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
