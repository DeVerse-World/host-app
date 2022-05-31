import 'package:flutter/material.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({Key? key}) : super(key: key);

  @override
  State createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text("abc"),
              Text("def")
            ],
          ),
          Column(
            children: [
              Text("abc"),
              Text("def"),
              Icon(Icons.add)
            ],
          )
        ],
      ),
    );
  }
}