import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final double size;
  final IconData icon;
  final VoidCallback onPressed;

  const CircularButton({
    this.size = 56.0,
    required this.icon,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(size / 2),
        onTap: onPressed,
        child: Container(
          width: size,
          height: size,
          child: Center(child:Text('Scan',style: TextStyle(color:Colors.white),))
        ),
      ),
    );
  }
}
