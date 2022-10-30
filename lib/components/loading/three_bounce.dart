// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:todo_app/components/loading/dot.dart';

class ThreeBounce extends StatelessWidget {
  final Color? color;

  const ThreeBounce({
    Key? key,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // dot1
        SizedBox(
          width: 12,
          height: 12,
          child: Center(
            child: Dot(
              color: color ?? Colors.white,
              delayTime: 0,
            ),
          ),
        ),
        const SizedBox(width: 6),
        // dot2
        SizedBox(
          width: 12,
          height: 12,
          child: Center(
            child: Dot(
              color: color ?? Colors.white,
              delayTime: 300,
            ),
          ),
        ),
        const SizedBox(width: 6),
        // dot3
        SizedBox(
          width: 12,
          height: 12,
          child: Center(
            child: Dot(
              color: color ?? Colors.white,
              delayTime: 600,
            ),
          ),
        )
      ],
    );
  }
}
