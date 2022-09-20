import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog(
      {Key? key,
      required this.text,
      this.onConfirm,
      this.onCancel,
      this.conformText,
      this.cancelText,
      this.title})
      : super(key: key);
  final String? title;
  final String text;
  final String? conformText;
  final String? cancelText;
  final Function? onConfirm;
  final Function? onCancel;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: title != null
          ? Text(
              title!,
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            )
          : null,
      content: Text(text),
      actions: [_cancelButton(context), _confirmButton(context)],
    );
  }

  Widget _confirmButton(BuildContext context) {
    return TextButton(
        onPressed: () {
          onConfirm?.call();
        },
        child: Text(conformText ?? 'Ok'));
  }

  _cancelButton(BuildContext context) {
    return TextButton(
        onPressed: () {
          onCancel?.call();
          Navigator.pop(context);
        },
        child: Text(cancelText ?? 'Cancel'));
  }
}
