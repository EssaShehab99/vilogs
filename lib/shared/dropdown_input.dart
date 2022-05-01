import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constant_values.dart';
import '../styles/colors_app.dart';
import 'custom_input_border.dart';

class DropdownInput extends StatelessWidget {
  DropdownInput({
    Key? key,
    this.items,
    this.width,
    this.hint,
    this.itemHeight,
    this.prefixIcon,
    this.readOnly = false,
    this.isDense = false,
    this.paddingTop,
    this.defaultValue,
    this.labelText,
    this.keyDropDown,
    this.validator,
    this.onChanged,
  }) : super(key: key);
  final List<String>? items;
  final String? hint;
  final String? labelText;
  final FormFieldValidator<String>? validator;
  final double? width;
  final ValueChanged<String>? onChanged;
  final bool? paddingTop;
  final Widget? prefixIcon;
  final bool readOnly;
  final double? itemHeight;
  final String? defaultValue;
  final Key? keyDropDown;
  final bool isDense;

  @override
  Widget build(BuildContext context) {
    String? selectedValue = defaultValue;
    return CustomInputBorder(
      labelText: labelText,
      paddingTop: paddingTop ?? true,
      child: DropdownButtonFormField<String>(
        key: keyDropDown,
        onChanged: (value) {
          onChanged!(value.toString());
        },
        iconSize: 0.0,
        isDense: isDense,
        itemHeight: itemHeight /*?? 55*/,
        hint: Padding(
          padding:  EdgeInsetsDirectional.only(start: 8.0),
          child: Text(hint ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontStyle: FontStyle.italic, color: ColorsApp.grey)),
        ),
        value: selectedValue,
        validator: validator,
        items: readOnly
            ? null
            : items
                ?.map((value) => DropdownMenuItem<String>(
                      value: value,
                      child: Container(
                          width: width,
                          child: FittedBox(
                            alignment: AlignmentDirectional.centerStart,
                              fit: BoxFit.scaleDown, child: Text(value))),
                    ))
                .toList(),
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: Icon(Icons.arrow_drop_down),
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(ConstantValues.radius)),
            borderSide: BorderSide(color: ColorsApp.border, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorsApp.primary, width: 2.0)),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          // hintText: widget.hint,
        ),
      ),
    );
  }
}
