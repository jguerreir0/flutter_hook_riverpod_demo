import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RichTextClickableComponent extends HookWidget {
  final String richTextLabel;
  final VoidCallback onTap;

  ///Creates a Text with a clickable component
  const RichTextClickableComponent({
    super.key,
    required this.richTextLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: richTextLabel,
        style: TextStyle(color: Colors.grey.shade500),
        children: <TextSpan>[
          TextSpan(
            text: 'Click here',
            style: const TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
