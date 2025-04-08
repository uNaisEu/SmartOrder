import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:another_flushbar/flushbar.dart';


Flushbar showAnotherSnackBar(
    BuildContext context, 
    String content, { 
      Color? backgroundColor,
      Duration? duration = const Duration(milliseconds: 4000), 
      bool blockBackgroundInteraction = false,
      bool isDismissible = true,
      bool showProgressIndicator = false,
      Widget? mainButton,
}) {
  backgroundColor ??= Theme.of(context).colorScheme.errorContainer.withValues(alpha: 0.8);
  return Flushbar(
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
    backgroundColor: backgroundColor,
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    duration: duration,
    animationDuration: const Duration(milliseconds: 800),
    blockBackgroundInteraction: blockBackgroundInteraction,
    isDismissible: isDismissible,
    showProgressIndicator: showProgressIndicator,
    messageText: GestureDetector(
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: content));
      },
      child: Text(
        content,
        maxLines: 2,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onErrorContainer
        ),
      )
    ),
    mainButton: mainButton,
  )..show(context);
}