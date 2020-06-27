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
              color: selected
                  ? Colors.blue
                  : value == 1 || value == 2 ? Colors.transparent : borderColor,
              width: selected ? 1 : value == null ? 0 : 4),
          borderRadius: BorderRadius.circular(size / 2),
        ),
        child: Center(
          child: Container(
            width: value == null ? size / 1.8 : size / 2,
            height: value == null ? size / 1.8 : size / 2,
            decoration: BoxDecoration(
              color: selected
                  ? Colors.blue
                  : value == null ? Colors.transparent : borderColor,
              borderRadius: BorderRadius.circular(size / 2),
            ),
          ),
        )),
  );
}
