import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

TextFormField baseTextField(
    {required Function(String) onChanged,
    required TextEditingController? controller,
    String hintText = '',
    void Function()? onTap,
    bool readOnly = false,
    bool isObscure = false,
    bool isPhone = false,
    bool isOutline = false,
    int? maxLength,
    int? maxLines,
    Widget? icon,
    InputBorder? enabledBorder,
    InputBorder? focusedBorder,
    InputBorder? errorBorder,
    InputBorder? focusedErrorBorder,
    TextStyle? textStyle,
    double? horizontal,
    double? vertical,
    FormFieldValidator<String>? validator}) {
  return TextFormField(
    onTap: onTap,
    maxLines: maxLines,
    readOnly: readOnly,
    inputFormatters: [
      LengthLimitingTextInputFormatter(maxLength),
    ],
    obscureText: isObscure,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    controller: controller,
    textAlign: TextAlign.start,
    validator: validator,
    textCapitalization: TextCapitalization.words,
    keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
    style:
        textStyle ?? const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
    //focusNode: focusNode,
    onChanged: onChanged,
    decoration: InputDecoration(
      hintStyle: text12.copyWith(color: greyColor),
      filled: true,
      fillColor: Colors.white,
      hintText: hintText,
      suffixIconConstraints: const BoxConstraints(minHeight: 20, minWidth: 30),
      suffixIcon: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: icon,
      ),
      focusedBorder: focusedBorder ??
          (isOutline
              ? outLineInputBorder(width: 1, color: greyBorderColor)
              : InputBorder.none),
      enabledBorder: enabledBorder ??
          (isOutline
              ? outLineInputBorder(width: 1, color: greyBorderColor)
              : InputBorder.none),
      errorBorder: errorBorder ??
          (isOutline
              ? outLineInputBorder(width: 1, color: Colors.red)
              : InputBorder.none),
      focusedErrorBorder: focusedErrorBorder ??
          (isOutline
              ? outLineInputBorder(width: 1, color: Colors.red)
              : InputBorder.none),
      contentPadding: EdgeInsets.symmetric(
        horizontal: horizontal ?? 15,
        vertical: vertical ?? 15,
      ),
      isDense: true,
    ),
  );
}

UnderlineInputBorder underLineIntputBorder(
    {required double width, required color}) {
  return UnderlineInputBorder(
    borderSide: BorderSide(color: color, width: width),
  );
}

OutlineInputBorder outLineInputBorder({required double width, required color}) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: color, width: width),
  );
}

const text12 = TextStyle(fontSize: 12, fontWeight: FontWeight.w400);
const text14 = TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
const text16 = TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
const text18 = TextStyle(fontSize: 18, fontWeight: FontWeight.w400);
const text20 = TextStyle(fontSize: 20, fontWeight: FontWeight.w400);

const greyBorderColor = Color(0xFFD3D3D3);
const greyColor = Color(0xFF8B8181);
