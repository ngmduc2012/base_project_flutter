import 'dart:ffi';

import 'package:flutter/material.dart';

class CaptureButtonWidget extends StatefulWidget {
  final ValueChanged<void>? onTap;

   CaptureButtonWidget({required this.onTap});

  @override
  _CaptureButtonWidgetState createState() => _CaptureButtonWidgetState();
}

class _CaptureButtonWidgetState extends State<CaptureButtonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _size;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    final Animation<double> curve =
        CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _size = Tween<double>(begin: 52, end: 40).animate(curve)
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapCancel: () {
        _controller.reverse();
      },
      onTapUp: (_) {
        _controller.reverse().then((_) {
          widget.onTap?.call(Void);
        });
      },
      onTapDown: (_) {
        _controller.forward();
      },
      child: SizedBox(
        height: 70,
        width: 70,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: _size.value,
                width: _size.value,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(35),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
