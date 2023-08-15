import 'package:flutter/material.dart';
import 'package:tictactoe/utils/colors.dart';
import 'package:tictactoe/utils/responsive.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final Function(String)? onChanged;
  final String hintText;
  final bool isReadOnly;
  final TextAlign textAlignment;
  const CustomTextField({
    super.key,
    this.isReadOnly = false,
    required this.hintText,
    this.textAlignment = TextAlign.left,
    required this.textEditingController,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: textFieldResponsiveSize.height,
        maxWidth: textFieldResponsiveSize.width,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            10.0,
          ),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            spreadRadius: 1,
            color: glowColor,
          )
        ],
      ),
      child: TextField(
        textAlign: textAlignment,
        readOnly: isReadOnly,
        onChanged: onChanged,
        
        controller: textEditingController,
        decoration: InputDecoration(
          focusColor: glowColor,
          fillColor: Colors.black,
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.greenAccent,
              width: 2.0,
            ),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(color: glowColor),
          ),
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }
}
