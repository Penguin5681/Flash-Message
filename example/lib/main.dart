import 'package:flutter/material.dart';
import 'package:flash_message/flash_message.dart';

/// The main entry point of the application.
void main() {
  runApp(const MyApp());
}

/// The main application widget.
class MyApp extends StatelessWidget {
  /// Creates a [MyApp] widget.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flash Message Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FlashMessageOverlay(
        position: FlashMessagePosition.top,
        child: MyHomePage(),
      ),
    );
  }
}

/// The home page of the application.
class MyHomePage extends StatelessWidget {
  /// Creates a [MyHomePage] widget.
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flash Message Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                FlashMessageService().showMessage(
                  message: 'Success!',
                  description: 'Operation completed successfully',
                  type: FlashMessageType.success,
                );
              },
              child: const Text('Show Success Message'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                FlashMessageService().showMessage(
                  message: 'Error!',
                  description: 'Something went wrong',
                  type: FlashMessageType.error,
                );
              },
              child: const Text('Show Error Message'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                FlashMessageService().showMessage(
                  message: 'Update!',
                  description: 'Your package has been shipped',
                  type: FlashMessageType.info,
                );
              },
              child: const Text('Show Info Message'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                FlashMessageService().showMessage(
                  message: 'Warning!',
                  description: 'You are about to sign out',
                  type: FlashMessageType.warning,
                );
              },
              child: const Text('Show Warning Message'),
            ),
          ],
        ),
      ),
    );
  }
}
