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
    int? maxLength,
    Widget? icon,
    InputBorder? enabledBorder,
    InputBorder? focusedBorder,
    InputBorder? errorBorder,
    InputBorder? focusedErrorBorder,
    bool isOutline = false,
    FormFieldValidator<String>? validator}) {
  return TextFormField(
    onTap: onTap,
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
    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
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
              : underLineIntputBorder(width: 1, color: greyBorderColor)),
      enabledBorder: enabledBorder ??
          (isOutline
              ? outLineInputBorder(width: 1, color: greyBorderColor)
              : underLineIntputBorder(width: 1, color: greyBorderColor)),
      errorBorder: errorBorder ??
          (isOutline
              ? outLineInputBorder(width: 1, color: Colors.red)
              : underLineIntputBorder(width: 1, color: Colors.red)),
      focusedErrorBorder: focusedErrorBorder ??
          (isOutline
              ? outLineInputBorder(width: 1, color: Colors.red)
              : underLineIntputBorder(width: 1, color: Colors.red)),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
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
