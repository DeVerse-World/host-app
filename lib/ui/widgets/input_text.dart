import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  const InputText({Key? key,this.keyboardType, this.inputDecoration }) : super(key: key);

  final TextInputType? keyboardType;
  final InputDecoration? inputDecoration;
  @override
  State createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  final TextEditingController _controller = TextEditingController();


  @override
  void initState() {
    // widget.inputDecoration?.hintText = "a";
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        keyboardType: widget.keyboardType,
        controller: _controller,
        decoration: widget.inputDecoration
          // hintText: "e.g: My awesome verse",
          // icon: Icon(Icons.favorite),
          // labelText: 'Label text',
          // labelStyle: TextStyle(
          //   color: Color(0xFF6200EE),
          // ),
          // helperText: 'Helper text',
          // suffixIcon: Icon(
          //   Icons.check_circle,
          // ),
          // enabledBorder: UnderlineInputBorder(
          //   borderSide: BorderSide(color: Color(0xFF6200EE)),
          // ),

    );
  }
}