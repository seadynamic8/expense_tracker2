import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Text('Bar 1'),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Icon(Icons.travel_explore),
          ],
        ),
      ],
    );
  }
}
