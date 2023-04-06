import 'package:flutter/material.dart';

extension TextEditingControllerExt on TextEditingController {
  selectAll() {
    this.selection = TextSelection(baseOffset: 0, extentOffset: this.text.length);
  }

  bool get isAllSelected {
    return this.selection.start == 0 && this.selection.end == this.text.length;
  }
}
