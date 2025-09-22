import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  const CalculatorButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = const Color(0xFF333333),
    this.foregroundColor = Colors.white,
    this.width = 80,
    this.height = 80,
  });

  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: RawMaterialButton(
        onPressed: onPressed,
        elevation: 2.0,
        fillColor: backgroundColor,
        shape: const CircleBorder(),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 32,
            color: foregroundColor,
          ),
        ),
      ),
    );
  }
}
