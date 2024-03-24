import 'package:file_handler/constants.dart';
import 'package:file_handler/extensions.dart';
import 'package:flutter/material.dart';

class AppOutlinedButton extends StatefulWidget {
  const AppOutlinedButton({
    super.key,
    this.title,
    this.icon,
    this.color,
    this.onPressed,
  });

  const AppOutlinedButton.back({
    super.key,
    this.onPressed,
    this.color,
  })  : title = null,
        icon = Icons.arrow_back_ios_new_outlined;

  final String? title;
  final IconData? icon;
  final Color? color;
  final Function? onPressed;

  @override
  State<AppOutlinedButton> createState() => _AppOutlinedButtonState();
}

class _AppOutlinedButtonState extends State<AppOutlinedButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      colorBrightness: Brightness.dark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      minWidth: 16,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      color: widget.color ?? AppColor.ceruleanBlue.withOpacity(0.4),
      onPressed: isLoading || widget.onPressed == null
          ? null
          : widget.title == null && widget.icon == null
              ? () {
                  context.pop();
                }
              : () async {
                  setState(() => isLoading = true);
                  await widget.onPressed!();
                  if (context.mounted) setState(() => isLoading = false);
                },
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 120),
          child: widget.icon != null
              ? Icon(
                  widget.icon,
                  size: 16,
                )
              : Text(widget.title ?? 'Done'),
        ),
      ),
    );
  }
}
