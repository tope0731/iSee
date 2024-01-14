import 'package:flutter/material.dart';

AppBar apbar(BuildContext context) {
  return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 30,
        ),
      ));
}
