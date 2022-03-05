import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType inputType;
  final String? textEdit;

  const TextFieldWidget({Key? key,
  required this.controller,
  required this.hintText,
    this.textEdit,
  this.inputType = TextInputType.text}) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  void initState() {
        super.initState();
        widget.controller.text =widget.textEdit??'';

  }
  @override
  Widget build(BuildContext context) {
    return  TextField(
      controller: widget.controller,
      autofocus: true,
      textInputAction: TextInputAction.next,
      keyboardType: widget.inputType,
      style: const TextStyle(color: Colors.black),
      decoration:  InputDecoration(

        filled: true,
        fillColor: Colors.white,
        labelText: widget.hintText,

        contentPadding: const EdgeInsets.only(top: 5, bottom: 5,
            left: 15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color:  Colors.blue,
            width: 1
          )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
                color:  Colors.pink,
                width: 1.5
            )
        ),

        labelStyle: const TextStyle(color: Colors.grey,
        fontSize: 14),
      ),
    );
  }
}
