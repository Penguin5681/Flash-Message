import 'package:flutter/material.dart';

import '../enums/message_type.dart';
import '../models/flash_message_model.dart';

/// A widget that displays a flash message with an icon, message, and optional description.
///
/// The widget is dismissible and can be tapped to trigger an action.
class FlashMessageWidget extends StatelessWidget {
  /// The flash message to display.
  final FlashMessage message;

  /// Callback to be called when the message is dismissed.
  final VoidCallback onDismiss;

  /// Creates a [FlashMessageWidget].
  const FlashMessageWidget({
    super.key,
    required this.message,
    required this.onDismiss,
  });

  /// Returns the default background color based on the message type.
  Color _getDefaultBackgroundColor(BuildContext context) {
    switch (message.type) {
      case FlashMessageType.success:
        return Colors.green;
      case FlashMessageType.error:
        return Colors.red;
      case FlashMessageType.warning:
        return Colors.orange;
      case FlashMessageType.info:
        return Theme.of(context).primaryColor;
    }
  }

  /// Returns the default icon based on the message type.
  IconData _getDefaultIcon() {
    switch (message.type) {
      case FlashMessageType.success:
        return Icons.check_circle;
      case FlashMessageType.error:
        return Icons.error;
      case FlashMessageType.warning:
        return Icons.warning;
      case FlashMessageType.info:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: message.backgroundColor ?? _getDefaultBackgroundColor(context),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: message.onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  message.icon ?? _getDefaultIcon(),
                  color: message.textColor ?? Colors.white,
                ),
                const SizedBox(width: 12.0),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.message,
                        style: TextStyle(
                          color: message.textColor ?? Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (message.description != null) ...[
                        const SizedBox(height: 4.0),
                        Text(
                          message.description!,
                          style: TextStyle(
                            color: message.textColor ?? Colors.white,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: message.textColor ?? Colors.white,
                  ),
                  onPressed: onDismiss,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
