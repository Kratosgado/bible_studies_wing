import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputField extends StatefulWidget {
  final String label;
  final TextEditingController controller;

  const InputField({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  State<InputField> createState() => _CustomTextFieldWithMovingLabelState();
}

class _CustomTextFieldWithMovingLabelState extends State<InputField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: _focusNode,
      style: context.textTheme.bodyMedium,
      decoration: InputDecoration(
        // Use a Row to conditionally place the label in the prefix or suffix based on focus
        suffixIcon: _isFocused || widget.controller.text.isNotEmpty
            ? Align(
                alignment: Alignment.centerRight,
                child: Text(widget.label, style: const TextStyle(color: Colors.black)))
            : null,
        prefixIcon: !_isFocused && widget.controller.text.isEmpty
            ? Text(widget.label, style: const TextStyle(color: Colors.black))
            : null,
        // Other styling here
      ),
    );
  }
}
