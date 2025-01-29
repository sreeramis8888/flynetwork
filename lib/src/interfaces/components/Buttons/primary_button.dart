import 'package:flutter/material.dart';
import 'package:flynetwork/src/data/constants/color_constants.dart';

Widget primaryButton({
  required String label,
  required VoidCallback onPressed,
  Color sideColor = kPrimaryColor,
  Color labelColor = Colors.white,
  int fontSize = 16,
  int buttonHeight = 45,
  Color buttonColor = kPrimaryColor,
}) {
  return SizedBox(
    height: buttonHeight.toDouble(),
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(0), // Remove elevation
        backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: sideColor),
          ),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: labelColor,
          fontSize: double.parse(fontSize.toString()),
        ),
      ),
    ),
  );
}
