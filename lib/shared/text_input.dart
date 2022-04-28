import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/constant_values.dart';
import '../styles/colors_app.dart';
import 'custom_input_border.dart';

class TextInput extends StatelessWidget {
  TextInput(
      {Key? key,
      required this.controller,
      this.hint,
      this.labelText,
      this.icon,
      this.validator,
      this.keyboardType,
      this.enabled,
      this.obscureText,
      this.textDirection,
      this.suffixIcon,
      this.textInputAction,
      this.textAlign = TextAlign.start,
      this.length})
      : super(key: key);
  final TextEditingController controller;
  final String? hint;
  final String? labelText;
  final IconData? icon;
  final bool? enabled;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final TextDirection? textDirection;
  final int? length;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return CustomInputBorder(
      labelText: labelText,
      child: TextFormField(
        textInputAction: textInputAction ?? TextInputAction.next,
        validator: validator,
        textDirection: textDirection,
        controller: controller,
        obscureText: obscureText ?? false,
        keyboardType: keyboardType,
        enabled: enabled,
        textAlign: textAlign,
        inputFormatters: length != null
            ? [
                LengthLimitingTextInputFormatter(length!),
                FilteringTextInputFormatter.digitsOnly
              ]
            : [],
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(ConstantValues.radius)),
            borderSide: BorderSide(color: ColorsApp.border, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorsApp.primary, width: 2.0)),
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.all(10),
          hintText: hint,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(fontStyle: FontStyle.italic, color: ColorsApp.grey),
          prefixIcon:
              icon == null ? null : Icon(icon, color: ColorsApp.primary),
        ),
      ),
    );
  }
}
