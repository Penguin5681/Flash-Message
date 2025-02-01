import 'dart:async';

import 'package:flash_message/src/enums/message_type.dart';
import 'package:flutter/material.dart';

import '../models/flash_message_model.dart';

/// Service to manage flash messages
class FlashMessageService {
  static final FlashMessageService _instance = FlashMessageService._internal();

  /// Factory constructor to return the same static instance
  factory FlashMessageService() => _instance;

  FlashMessageService._internal();

  final _controller = StreamController<FlashMessage>.broadcast();

  /// Stream of flash messages
  Stream<FlashMessage> get messages => _controller.stream;

  /// Shows a new flash message
  void showMessage({
    required String message,
    String? description,
    FlashMessageType type = FlashMessageType.info,
    Duration duration = const Duration(seconds: 3),
    Color? backgroundColor,
    Color? textColor,
    IconData? icon,
    VoidCallback? onTap,
  }) {
    if (!_controller.isClosed) {
      _controller.add(FlashMessage(
        message: message,
        description: description,
        type: type,
        duration: duration,
        backgroundColor: backgroundColor,
        textColor: textColor,
        icon: icon,
        onTap: onTap,
      ));
    }
  }

  void clearMessages() {
    _controller.close();
    _controller.sink.close();
  }

  /// Disposes of the service
  void dispose() {
    if (!_controller.isClosed) {
      _controller.close();
    }
  }
}
