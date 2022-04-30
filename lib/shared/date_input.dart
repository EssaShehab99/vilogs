// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../constants/constant_values.dart';
// import '../styles/colors_app.dart';
// import 'custom_input_border.dart';
//
// class DateInput extends StatefulWidget {
//   DateInput({
//     Key? key,
//     this.hint,
//     this.labelText,
//     this.validator,
//     this.onChanged,
//   }) : super(key: key);
//   final String? hint;
//   final String? labelText;
//   final FormFieldValidator<String>? validator;
//   final ValueChanged<DateTime>? onChanged;
//
//   @override
//   State<DateInput> createState() => _DateInputState();
// }
//
// class _DateInputState extends State<DateInput> {
//   final dropdownState = GlobalKey<FormFieldState>();
//   String? selectedValue;
//   List<bool> selected = [];
//   String? dateText;
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomInputBorder(
//       labelText: widget.labelText,
//       child: TextFormField(
//         validator: widget.validator,
//         controller: TextEditingController(text: dateText),
//         readOnly: true,
//         onTap: () async {
//           DateTime? pickedDate = await showDatePicker(
//             context: context,
//             initialDate: DateTime.now(),
//             firstDate: DateTime(2010),
//             lastDate: DateTime(2025),
//           );
//           if (pickedDate != null) {
//             if(widget.onChanged!=null) {
//               dateText=DateFormat('yyyy-MM-dd').format(pickedDate);
//               widget.onChanged!(pickedDate);
//               setState(() {
//
//               });
//             }
//           } else {
//           }
//         },
//         style: Theme.of(context).textTheme.bodyText1,
//         decoration: InputDecoration(
//           suffixIcon: Icon(Icons.date_range),
//           border: OutlineInputBorder(
//             borderRadius:
//                 BorderRadius.all(Radius.circular(ConstantValues.radius)),
//             borderSide: BorderSide(color: ColorsApp.border, width: 2.0),
//           ),
//           focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: ColorsApp.primary, width: 2.0)),
//           contentPadding: EdgeInsets.all(10),
//           hintText: widget.hint,
//           hintStyle: Theme.of(context)
//               .textTheme
//               .bodyText1
//               ?.copyWith(fontStyle: FontStyle.italic, color: ColorsApp.grey),
//         ),
//       ),
//     );
//   }
// }
