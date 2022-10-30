import 'package:flutter/material.dart';
import 'package:todo_app/components/base_text_field.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {Key? key,
      required this.text,
      this.height = 50,
      this.isDisable = false,
      this.textColor = Colors.white,
      this.disableTextColor,
      this.primaryColor,
      this.disablePrimaryColor,
      this.border,
      this.disableBorder,
      this.width})
      : super(key: key);

  final String text;
  final double height;
  final bool isDisable;
  final Color? textColor;
  final Color? disableTextColor;
  final Color? primaryColor;
  final Color? disablePrimaryColor;
  final Border? border;
  final Border? disableBorder;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: isDisable
            ? disablePrimaryColor ?? const Color(0xFFF5F5F5)
            : primaryColor ?? Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(6),
        border: isDisable ? disableBorder : border,
      ),
      child: Center(
        child: Text(
          text,
          style: text16.copyWith(
            color: isDisable
                ? disableTextColor ?? const Color.fromRGBO(89, 89, 89, 100)
                : textColor,
          ),
        ),
      ),
    );
  }
}
