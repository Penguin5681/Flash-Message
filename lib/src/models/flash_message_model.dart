import 'package:flutter/material.dart';
import '../enums/message_type.dart';

/// Model class for flash messages
class FlashMessage {
  /// The main message text
  final String message;

  /// Optional description text
  final String? description;

  /// The type of message (success, error, info, warning)
  final FlashMessageType type;

  /// How long the message should be displayed
  final Duration duration;

  /// Optional custom background color
  final Color? backgroundColor;

  /// Optional custom text color
  final Color? textColor;

  /// Optional icon to display
  final IconData? icon;

  /// Optional callback when message is tapped
  final VoidCallback? onTap;

  /// Creates a new flash message
  const FlashMessage({
    required this.message,
    this.description,
    this.type = FlashMessageType.info,
    this.duration = const Duration(seconds: 3),
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.onTap,
  });
}
