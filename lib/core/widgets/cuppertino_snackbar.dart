// lib/widgets/cupertino_snackbar.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // For Colors, can be replaced with CupertinoColors if preferred

class CupertinoSnackbar extends StatefulWidget {
  final String message;
  final Duration duration;
  final VoidCallback? onDismissed; // Callback when snackbar is gone

  const CupertinoSnackbar({
    super.key,
    required this.message,
    this.duration = const Duration(seconds: 3),
    this.onDismissed,
  });

  @override
  _CupertinoSnackbarState createState() => _CupertinoSnackbarState();
}

class _CupertinoSnackbarState extends State<CupertinoSnackbar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0), // Start off-screen (bottom)
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward(); // Animate in

    Future.delayed(widget.duration - const Duration(milliseconds: 300), () {
      if (mounted) {
        _controller.reverse().then((_) {
          if (widget.onDismissed != null) {
            widget.onDismissed!();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: SafeArea( // Ensures it doesn't overlap system UI
        bottom: true, // Only apply safe area to the bottom
        top: false,
        left: false,
        right: false,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.black87.withOpacity(0.8), // Cupertino-like dark background
            borderRadius: BorderRadius.circular(14.0), // Rounded corners
          ),
          child: DefaultTextStyle(
            style: TextStyle(color: Colors.white, fontSize: 15),
            child: Text(widget.message),
          ),
        ),
      ),
    );
  }
}

// Helper function to show the custom snackbar
void showCupertinoSnackBar({
  required BuildContext context,
  required String message,
  Duration duration = const Duration(seconds: 3),
}) {
  OverlayEntry? overlayEntry; // Make it nullable

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 0, // Position at the bottom
      left: 0,
      right: 0,
      child: CupertinoSnackbar(
        message: message,
        duration: duration,
        onDismissed: () {
          if (overlayEntry != null) {
            overlayEntry!.remove();
            overlayEntry = null; // Clear the reference
          }
        },
      ),
    ),
  );

  Overlay.of(context).insert(overlayEntry!);
}