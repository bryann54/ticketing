import 'package:flutter/material.dart';
import 'package:ticketing/features/venues/data/models/seat_model.dart';

class SeatWidget extends StatefulWidget {
  final SeatModel seat;
  final bool isSelected;
  final Function(String) onTap;
  final bool isBooked;

  const SeatWidget({
    super.key,
    required this.seat,
    required this.isSelected,
    required this.onTap,
    this.isBooked = false,
  });

  @override
  State<SeatWidget> createState() => _SeatWidgetState();
}

class _SeatWidgetState extends State<SeatWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!widget.isBooked) {
      setState(() => _isPressed = true);
      _animationController.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.isBooked) {
      setState(() => _isPressed = false);
      _animationController.reverse();
      widget.onTap(widget.seat.name);
    }
  }

  void _handleTapCancel() {
    if (!widget.isBooked) {
      setState(() => _isPressed = false);
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isAisle = widget.seat.leftAisle ||
        widget.seat.rightAisle ||
        widget.seat.frontAisle ||
        widget.seat.backAisle;

    // Color scheme based on seat state
    Color primarySeatColor;
    Color secondarySeatColor;
    Color shadowColor;
    Color textColor;

    if (widget.isBooked) {
      primarySeatColor = Colors.grey[400]!;
      secondarySeatColor = Colors.grey[300]!;
      shadowColor = Colors.grey[600]!;
      textColor = Colors.grey[600]!;
    } else if (widget.isSelected) {
      primarySeatColor = theme.colorScheme.primary;
      secondarySeatColor = theme.colorScheme.primary.withValues(alpha: 0.8);
      shadowColor = theme.colorScheme.primary.withValues(alpha: 0.6);
      textColor = theme.colorScheme.onPrimary;
    } else if (isAisle) {
      primarySeatColor = theme.colorScheme.tertiary;
      secondarySeatColor = theme.colorScheme.tertiary.withValues(alpha: 0.8);
      shadowColor = theme.colorScheme.tertiary.withValues(alpha: 0.6);
      textColor = theme.colorScheme.onTertiary;
    } else {
      primarySeatColor = theme.colorScheme.surfaceContainerHighest;
      secondarySeatColor = theme.colorScheme.surfaceContainer;
      shadowColor = theme.colorScheme.outline.withValues(alpha: 0.3);
      textColor = theme.colorScheme.onSurface;
    }

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: _handleTapDown,
            onTapUp: _handleTapUp,
            onTapCancel: _handleTapCancel,
            child: SizedBox(
              width: 32,
              height: 32,
              child: CustomPaint(
                painter: TheatreSeatPainter(
                  primaryColor: primarySeatColor,
                  secondaryColor: secondarySeatColor,
                  shadowColor: shadowColor,
                  isPressed: _isPressed,
                  isSelected: widget.isSelected,
                  isBooked: widget.isBooked,
                  isAisle: isAisle,
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    widget.seat.name,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 8,
                      shadows: widget.isSelected
                          ? [
                              Shadow(
                                offset: const Offset(0.5, 0.5),
                                blurRadius: 1,
                                color: Colors.black.withValues(alpha: 0.3),
                              ),
                            ]
                          : null,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TheatreSeatPainter extends CustomPainter {
  final Color primaryColor;
  final Color secondaryColor;
  final Color shadowColor;
  final bool isPressed;
  final bool isSelected;
  final bool isBooked;
  final bool isAisle;

  TheatreSeatPainter({
    required this.primaryColor,
    required this.secondaryColor,
    required this.shadowColor,
    required this.isPressed,
    required this.isSelected,
    required this.isBooked,
    required this.isAisle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final width = size.width;
    final height = size.height;

    // Draw shadow (bottom/right offset for 3D effect)
    if (!isPressed) {
      paint.color = shadowColor;
      final shadowOffset = isSelected ? 2.0 : 1.5;

      // Seat back shadow
      final shadowBackRect = RRect.fromRectAndCorners(
        Rect.fromLTWH(
          shadowOffset,
          shadowOffset,
          width * 0.85,
          height * 0.4,
        ),
        topLeft: const Radius.circular(8),
        topRight: const Radius.circular(8),
        bottomLeft: const Radius.circular(4),
        bottomRight: const Radius.circular(4),
      );
      canvas.drawRRect(shadowBackRect, paint);

      // Seat cushion shadow
      final shadowCushionPath = Path();
      shadowCushionPath.addRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
            shadowOffset + 1,
            height * 0.35 + shadowOffset,
            width * 0.75,
            height * 0.55,
          ),
          topLeft: const Radius.circular(6),
          topRight: const Radius.circular(6),
          bottomLeft: const Radius.circular(10),
          bottomRight: const Radius.circular(10),
        ),
      );
      canvas.drawPath(shadowCushionPath, paint);
    }

    // Draw seat back
    paint.color = secondaryColor;
    final backRect = RRect.fromRectAndCorners(
      Rect.fromLTWH(
        1,
        isPressed ? 1.5 : 0,
        width * 0.85,
        height * 0.4,
      ),
      topLeft: const Radius.circular(8),
      topRight: const Radius.circular(8),
      bottomLeft: const Radius.circular(4),
      bottomRight: const Radius.circular(4),
    );
    canvas.drawRRect(backRect, paint);

    // Draw seat back highlight
    paint.color = primaryColor.withValues(alpha: 0.3);
    final backHighlight = RRect.fromRectAndCorners(
      Rect.fromLTWH(
        2,
        (isPressed ? 1.5 : 0) + 1,
        width * 0.75,
        height * 0.15,
      ),
      topLeft: const Radius.circular(6),
      topRight: const Radius.circular(6),
    );
    canvas.drawRRect(backHighlight, paint);

    // Draw main seat cushion
    paint.color = primaryColor;
    final cushionPath = Path();
    cushionPath.addRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(
          2,
          height * 0.35 + (isPressed ? 1.5 : 0),
          width * 0.75,
          height * 0.55,
        ),
        topLeft: const Radius.circular(6),
        topRight: const Radius.circular(6),
        bottomLeft: const Radius.circular(10),
        bottomRight: const Radius.circular(10),
      ),
    );
    canvas.drawPath(cushionPath, paint);

    // Draw cushion padding lines for texture
    paint.color = secondaryColor;
    paint.strokeWidth = 0.5;
    paint.style = PaintingStyle.stroke;

    final paddingY = height * 0.35 + (isPressed ? 1.5 : 0) + height * 0.15;
    canvas.drawLine(
      Offset(4, paddingY),
      Offset(width * 0.75 - 2, paddingY),
      paint,
    );

    // Draw cushion highlight
    paint.style = PaintingStyle.fill;
    paint.color = Colors.white.withValues(alpha: isSelected ? 0.3 : 0.2);
    final highlightRect = RRect.fromRectAndCorners(
      Rect.fromLTWH(
        3,
        height * 0.35 + (isPressed ? 1.5 : 0) + 2,
        width * 0.65,
        height * 0.2,
      ),
      topLeft: const Radius.circular(4),
      topRight: const Radius.circular(4),
    );
    canvas.drawRRect(highlightRect, paint);

    // Draw armrests
    paint.color = secondaryColor.withValues(alpha: 0.8);

    // Left armrest
    final leftArmrest = RRect.fromRectAndCorners(
      Rect.fromLTWH(
        0,
        height * 0.45 + (isPressed ? 1.5 : 0),
        width * 0.15,
        height * 0.35,
      ),
      topLeft: const Radius.circular(3),
      bottomLeft: const Radius.circular(6),
    );
    canvas.drawRRect(leftArmrest, paint);

    // Right armrest
    final rightArmrest = RRect.fromRectAndCorners(
      Rect.fromLTWH(
        width * 0.85,
        height * 0.45 + (isPressed ? 1.5 : 0),
        width * 0.15,
        height * 0.35,
      ),
      topRight: const Radius.circular(3),
      bottomRight: const Radius.circular(6),
    );
    canvas.drawRRect(rightArmrest, paint);

    // Add special effects for different states
    if (isSelected) {
      // Glow effect for selected seats
      paint.color = primaryColor.withValues(alpha: 0.3);
      paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
      final glowRect = RRect.fromRectAndCorners(
        Rect.fromLTWH(-2, -2, width + 4, height + 4),
        topLeft: const Radius.circular(12),
        topRight: const Radius.circular(12),
        bottomLeft: const Radius.circular(12),
        bottomRight: const Radius.circular(12),
      );
      canvas.drawRRect(glowRect, paint);
      paint.maskFilter = null;
    }

    if (isAisle) {
      // Special indicator for aisle seats
      paint.color = Colors.amber;
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = 1.5;
      final aisleIndicator = RRect.fromRectAndCorners(
        Rect.fromLTWH(0.5, 0.5, width - 1, height - 1),
        topLeft: const Radius.circular(10),
        topRight: const Radius.circular(10),
        bottomLeft: const Radius.circular(12),
        bottomRight: const Radius.circular(12),
      );
      canvas.drawRRect(aisleIndicator, paint);
    }

    if (isBooked) {
      // X mark for booked seats
      paint.color = Colors.red[400]!;
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = 2;
      paint.strokeCap = StrokeCap.round;

      // Draw X
      canvas.drawLine(
        Offset(width * 0.25, height * 0.25),
        Offset(width * 0.75, height * 0.75),
        paint,
      );
      canvas.drawLine(
        Offset(width * 0.75, height * 0.25),
        Offset(width * 0.25, height * 0.75),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant TheatreSeatPainter oldDelegate) {
    return oldDelegate.primaryColor != primaryColor ||
        oldDelegate.secondaryColor != secondaryColor ||
        oldDelegate.shadowColor != shadowColor ||
        oldDelegate.isPressed != isPressed ||
        oldDelegate.isSelected != isSelected ||
        oldDelegate.isBooked != isBooked ||
        oldDelegate.isAisle != isAisle;
  }
}
