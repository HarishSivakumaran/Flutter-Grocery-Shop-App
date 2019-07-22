import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './input_helper.dart';

typedef void CaretMoved(Offset globalCaretPosition);
typedef void TextChanged(String text);

// Helper widget to track caret position.
class TrackingTextInput extends StatefulWidget {
  final Function validationFunction;
  final Function onSaved;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  TrackingTextInput({
    Key key,
    this.onCaretMoved,
    this.onTextChanged,
    this.onSaved,
    this.validationFunction,
    this.hint,
    this.label,
    this.isObscured = false,
    this.textEditingController ,this.textInputType
  }) : super(key: key);
  final CaretMoved onCaretMoved;
  final TextChanged onTextChanged;
  final String hint;
  final String label;
  final bool isObscured;
  @override
  _TrackingTextInputState createState() => _TrackingTextInputState();
}

class _TrackingTextInputState extends State<TrackingTextInput> {
  final GlobalKey _fieldKey = GlobalKey();
  Timer _debounceTimer;
  @override
  initState() {
    widget.textEditingController.addListener(() {
      // We debounce the listener as sometimes the caret position is updated after the listener
      // this assures us we get an accurate caret position.
      if (_debounceTimer?.isActive ?? false) _debounceTimer.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 100), () {
        if (_fieldKey.currentContext != null) {
          // Find the render editable in the field.
          final RenderObject fieldBox =
              _fieldKey.currentContext.findRenderObject();
          Offset caretPosition = getCaretPosition(fieldBox);

          if (widget.onCaretMoved != null) {
            widget.onCaretMoved(caretPosition);
          }
        }
      });
      if (widget.onTextChanged != null) {
        widget.onTextChanged(widget.textEditingController.text);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: widget.hint,
          labelText: widget.label,
        ),keyboardType: widget.textInputType,
        key: _fieldKey,
        controller: widget.textEditingController,
        obscureText: widget.isObscured,
        validator: widget.validationFunction,
        onSaved: widget.onSaved,
      ),
    );
  }
}
