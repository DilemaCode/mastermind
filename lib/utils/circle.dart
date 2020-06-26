import 'package:flutter/material.dart';

Widget circle(
    {Color color, bool selected, int value, double size, Function onTap}) {
  Color borderColor;
  selected = selected == null ? false : selected;
  switch (value) {
    case 0:
      borderColor = Colors.transparent;
      break;
    case 1:
      borderColor = Colors.black;
      break;
    case 2:
      borderColor = Colors.white;
      break;
    default:
      borderColor = Colors.grey[400];
  }
  return InkWell(
    borderRadius: BorderRadius.circular(size / 2),
    onTap: onTap,
    child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: selected
              ? Colors.transparent
              : value == null ? Colors.transparent : color,
          border: Border.all(
              color: selected ? Colors.blue : borderColor,
              width: selected ? 1 : value == null ? 1 : 4),
          borderRadius: BorderRadius.circular(size / 2),
        ),
        child: Center(
          child: Container(
            width: size / 1.8,
            height: size / 1.8,
            decoration: BoxDecoration(
              color: selected ? Colors.blue : Colors.transparent,
              borderRadius: BorderRadius.circular(size / 2),
            ),
          ),
        )),
  );
}
