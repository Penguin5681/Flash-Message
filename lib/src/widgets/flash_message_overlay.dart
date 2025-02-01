import 'dart:async';

import 'package:flutter/material.dart';

import '../models/flash_message_model.dart';
import '../services/flash_message_service.dart';
import 'flash_message_widget.dart';

/// Enum representing the position of the flash message on the screen.
enum FlashMessagePosition {
  /// Flash message appears at the top of the screen.
  top,

  /// Flash message appears at the center of the screen.
  center,

  /// Flash message appears at the bottom of the screen.
  bottom,
}

/// Widget that provides flash message functionality to its descendants
class FlashMessageOverlay extends StatefulWidget {
  final Widget child;
  final FlashMessagePosition position;

  const FlashMessageOverlay({
    super.key,
    required this.child,
    this.position = FlashMessagePosition.top,
  });

  @override
  State<FlashMessageOverlay> createState() => _FlashMessageOverlayState();
}

/// State class for `FlashMessageOverlay` widget.
/// Manages the display and animation of flash messages.
class _FlashMessageOverlayState extends State<FlashMessageOverlay> with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  OverlayEntry? _overlayEntry;
  Timer? _timer;
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  /// Initializes the state and sets up the animation controller and listener.
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _setupAnimation();
    FlashMessageService().messages.listen(_showMessage);
  }

  /// Sets up the animation based on the position of the flash message.
  void _setupAnimation() {
    Offset beginOffset;
    switch (widget.position) {
      case FlashMessagePosition.top:
        beginOffset = const Offset(0, -1);
        break;
      case FlashMessagePosition.bottom:
        beginOffset = const Offset(0, 1);
        break;
      case FlashMessagePosition.center:
        beginOffset = const Offset(0, -0.3);
        break;
    }

    _offsetAnimation = Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
  }

  /// Builds the overlay widget for the flash message.
  ///
  /// [message] The flash message to display.
  Widget _buildOverlayWidget(FlashMessage message) {
    return Positioned(
      left: 16,
      right: 16,
      top: _getTopPosition(context),
      bottom: _getBottomPosition(context),
      child: SlideTransition(
        position: _offsetAnimation,
        child: FlashMessageWidget(
          message: message,
          onDismiss: () {
            _animationController.reverse().then((_) {
              _overlayEntry?.remove();
              _overlayEntry = null;
              _timer?.cancel();
            });
          },
        ),
      ),
    );
  }

  /// Gets the top position for the flash message based on its position.
  ///
  /// [context] The build context.
  /// Returns the top position or null if not applicable.
  double? _getTopPosition(BuildContext context) {
    switch (widget.position) {
      case FlashMessagePosition.top:
        return MediaQuery.of(context).padding.top + 16;
      case FlashMessagePosition.center:
        return (MediaQuery.of(context).size.height - 100) / 2; // Approximate message height
      case FlashMessagePosition.bottom:
        return null;
    }
  }

  /// Gets the bottom position for the flash message based on its position.
  ///
  /// [context] The build context.
  /// Returns the bottom position or null if not applicable.
  double? _getBottomPosition(BuildContext context) {
    switch (widget.position) {
      case FlashMessagePosition.bottom:
        return MediaQuery.of(context).padding.bottom + 16;
      case FlashMessagePosition.top:
      case FlashMessagePosition.center:
        return null;
    }
  }

  /// Displays the flash message with animation.
  ///
  /// [message] The flash message to display.
  void _showMessage(FlashMessage message) {
    _timer?.cancel();
    _overlayEntry?.remove();
    _animationController.reset();

    _overlayEntry = OverlayEntry(
      builder: (context) => _buildOverlayWidget(message),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _animationController.forward();

    _timer = Timer(message.duration, () {
      _animationController.reverse().then((_) {
        _overlayEntry?.remove();
        _overlayEntry = null;
      });
    });
  }

  /// Disposes the animation controller and other resources.
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    _overlayEntry?.remove();
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      _timer?.cancel();
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  /// Builds the widget tree.
  ///
  /// [context] The build context.
  /// Returns the child widget.
  @override
  Widget build(BuildContext context) => widget.child;
}
