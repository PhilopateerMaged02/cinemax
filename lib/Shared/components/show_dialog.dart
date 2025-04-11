import 'package:cinemax/Shared/constants.dart';
import 'package:flutter/material.dart';

void showEditDialog({
  required BuildContext context,
  required String title,
  required String hintText,
  required VoidCallback onPressedUpdate,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
          ),
        ),
        TextButton(
          onPressed: onPressedUpdate,
          child: Text(
            "Update",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.w800),
          ),
        ),
      ],
    ),
  );
}
