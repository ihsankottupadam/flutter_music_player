import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputDialog extends StatelessWidget {
  InputDialog(
      {Key? key,
      required this.title,
      this.onConform,
      this.initialValue,
      this.cancelText,
      this.confirmText,
      this.onCancel,
      this.labelText,
      this.autofocus})
      : super(key: key);
  final String title;
  final String? initialValue;
  final String? cancelText;
  final String? confirmText;
  final String? labelText;
  final Function(String)? onConform;
  final VoidCallback? onCancel;
  final bool? autofocus;
  final tController = TextEditingController();
  final RxBool isTextEmpty = true.obs;

  @override
  Widget build(BuildContext context) {
    tController.text = initialValue ?? '';
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(title),
      titleTextStyle: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(fontWeight: FontWeight.bold),
      content: TextFormField(
          controller: tController,
          maxLength: 20,
          autofocus: autofocus ?? false,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
              hintText: labelText,
              counterText: '',
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 3, vertical: 0)),
          onChanged: (val) {
            isTextEmpty.value = val.trim().isEmpty;
          },
          onFieldSubmitted: (name) {
            onConform?.call(tController.text);
          }),
      actions: [_cancelButton(context), _confirmButton(context)],
    );
  }

  _confirmButton(BuildContext context) {
    return Obx(
      () => TextButton(
          onPressed: isTextEmpty.value
              ? null
              : () {
                  onConform?.call(tController.text);
                },
          child: Text(confirmText ?? 'Ok',
              style: const TextStyle(fontWeight: FontWeight.bold))),
    );
  }

  _cancelButton(BuildContext context) {
    return TextButton(
        onPressed: () {
          onCancel?.call();
          Navigator.pop(context);
        },
        child: Text(
          cancelText ?? 'Cancel',
        ));
  }
}
