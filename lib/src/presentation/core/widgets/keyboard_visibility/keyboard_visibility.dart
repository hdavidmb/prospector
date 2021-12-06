import 'package:flutter/material.dart';

class KeyboardVisibility extends StatefulWidget {
  final Widget? keyboardHiddenChild;
  final Widget? keyboardShowingChild;

  const KeyboardVisibility({
    Key? key,
    this.keyboardHiddenChild,
    this.keyboardShowingChild,
  })  : assert(keyboardHiddenChild != null || keyboardShowingChild != null),
        super(key: key);

  @override
  _KeyboardVisibilityState createState() => _KeyboardVisibilityState();
}

class _KeyboardVisibilityState extends State<KeyboardVisibility>
    with WidgetsBindingObserver {
  var _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance?.window.viewInsets.bottom;
    final newValue = bottomInset != null && bottomInset > 0.0;
    if (newValue != _isKeyboardVisible) {
      setState(() {
        _isKeyboardVisible = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) => _isKeyboardVisible
      ? widget.keyboardShowingChild ?? const SizedBox()
      : widget.keyboardHiddenChild ?? const SizedBox();
}
