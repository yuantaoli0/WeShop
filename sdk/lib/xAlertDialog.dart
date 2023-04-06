import 'package:flutter/material.dart';

import 'xView.dart';

class XAlertDialog extends XView {
  final XView page;
  double? height = 0;
  XAlertDialog(this.page, {super.key, this.height}) : super({}, null);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: dialogWidth(),
        height: height,
        child: page,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    );
  }
}
