import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final String? hintText;
  final String title;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final FormFieldValidator<String>? validator;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final Function()? onEditingComplete;

  const AppTextField({
    Key? key,
    this.hintText,
    this.controller,
    this.onChanged,
    this.keyboardType = TextInputType.number,
    this.inputFormatters,
    this.validator,
    this.autofocus = false,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
    this.onEditingComplete,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(height: 12),
        TextFormField(
          onFieldSubmitted: onFieldSubmitted,
          textInputAction: textInputAction,
          autofocus: autofocus,
          focusNode: focusNode,
          validator: validator,
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters ??
              [
                FilteringTextInputFormatter.allow(RegExp(r'(^-?\d*\.?\d*)')),
              ],
          onChanged: onChanged,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            errorMaxLines: 3,
            isDense: true,
            contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
            errorStyle: const TextStyle(
              fontSize: 12,
              color: Colors.red,
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: Colors.cyan),
            ),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.48)),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: Colors.redAccent, width: 1),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: Colors.redAccent, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.48)),
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
