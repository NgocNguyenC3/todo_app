import 'package:flutter/material.dart';
import 'package:todo_app/components/loading/base_button.dart';
import 'package:todo_app/components/loading/three_bounce.dart';

class LoadingButtonWidget extends StatelessWidget {
  const LoadingButtonWidget({
    Key? key,
    required this.submit,
    required this.isLoading,
    required this.label,
    this.height = 50,
    this.isDisable = false,
    this.textColor = Colors.white,
    this.disableTextColor,
    this.primaryColor,
    this.disablePrimaryColor,
    this.border,
    this.disableBorder,
  }) : super(key: key);

  final bool isLoading;
  final Function submit;
  final String label;
  final bool isDisable;
  final double height;
  final Color? textColor;
  final Color? disableTextColor;
  final Color? primaryColor;
  final Color? disablePrimaryColor;
  final Border? border;
  final Border? disableBorder;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: isLoading
          ? Container(
              height: height,
              decoration: BoxDecoration(
                color: isDisable ? const Color(0xFFF5F5F5) : primaryColor,
                borderRadius: BorderRadius.circular(6),
                border: isDisable ? disableBorder : border,
                boxShadow: [
                  BoxShadow(
                    //blurRadius: 6,
                    color: (primaryColor ?? Theme.of(context).primaryColor)
                        .withOpacity(0.5),
                    //offset: Offset(0, 4),
                  )
                ],
              ),
              alignment: Alignment.center,
              child: ThreeBounce(color: textColor),
            )
          : GestureDetector(
              onTap: () {
                if (!isDisable && !isLoading) {
                  submit();
                }
              },
              child: ButtonWidget(
                height: height,
                text: label,
                isDisable: isDisable,
                textColor: textColor,
                disableTextColor: disableTextColor,
                primaryColor: primaryColor,
                disablePrimaryColor: disablePrimaryColor,
                border: border,
                disableBorder: disableBorder,
              ),
            ),
    );
  }
}
