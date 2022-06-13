import 'package:deverse_host_app/data/models/sub_world_config.dart';
import 'package:flutter/material.dart';

class SubWorldConfigManagerView extends StatefulWidget {
  const SubWorldConfigManagerView({Key? key,
    required this.data, required this.onApply,required this.onDelete}) : super(key: key);

  final List<SubWorldConfig> data;
  final void Function(SubWorldConfig item) onApply;
  final void Function(SubWorldConfig item) onDelete;
  @override
  State createState() => _SubWorldConfigManagerState();
}

class _SubWorldConfigManagerState extends State<SubWorldConfigManagerView> {
  SubWorldConfig? _selectedSubWorldConfig;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        // thumbVisibility: true,
        child: ListView.builder(
          itemCount: widget.data.length,
          itemBuilder: (context, index) {
            var savedConfig = widget.data[index];
            return GestureDetector(onTap: () {
              setState(() {
                _selectedSubWorldConfig = savedConfig;
              });
            }, onDoubleTap: () {
              _selectedSubWorldConfig = savedConfig;
              widget.onApply(savedConfig);
            }, child: Container(color: _selectedSubWorldConfig?.id == savedConfig.id ? Colors.lightBlueAccent : Colors.white, child: Text(savedConfig.name)));
          },
        ),
      );
  }
}