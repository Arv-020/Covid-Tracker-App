import 'package:flutter/material.dart';

class ReusableRow extends StatelessWidget {
  final String title, value;
  final TextStyle style =
      const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: style,
              ),
              Text(
                value,
                style: style,
              )
            ],
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
