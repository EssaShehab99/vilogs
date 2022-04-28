import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constant_values.dart';
import '../styles/colors_app.dart';
import 'custom_input_border.dart';

class DropdownInput extends StatefulWidget {
  DropdownInput({
    Key? key,
    this.items,
    this.width,
    this.hint,
    this.labelText,
    this.validator,
    this.onChanged,
  }) : super(key: key);
  final List<String>? items;
  final String? hint;
  final String? labelText;
  final FormFieldValidator<String>? validator;
  final double? width;
  final ValueChanged<String>? onChanged;

  @override
  State<DropdownInput> createState() => _DropdownInputState();
}

class _DropdownInputState extends State<DropdownInput> {
  final dropdownState = GlobalKey<FormFieldState>();
  String? selectedValue;
  List<bool> selected = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomInputBorder(
      labelText: widget.labelText,
      child: DropdownButtonFormField(
        onChanged: (value) {
          widget.onChanged!(value.toString());
        },
        icon: Icon(Icons.arrow_drop_down),
        isDense: false,
        itemHeight: 55,
        value: selectedValue,
        validator: widget.validator,
        items: widget.items
            ?.map((value) => DropdownMenuItem<String>(
          value: value,
          child: Container(
              width: widget.width,
              child: FittedBox(
                  fit: BoxFit.scaleDown, child: Text(value))),
        ))
            .toList(),
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(ConstantValues.radius)),
            borderSide: BorderSide(color: ColorsApp.border, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorsApp.primary, width: 2.0)),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          hintText: widget.hint,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(fontStyle: FontStyle.italic, color: ColorsApp.grey),
        ),
      ),
    );
  }
}
