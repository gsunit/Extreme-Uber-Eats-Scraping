import 'package:flutter/material.dart';

Widget customAppBar({
  Widget leftButton,
  Widget rightButton,
  Widget title,
  Color bgColor,
}) {
  return Container(
    color: bgColor,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        leftButton,
        title,
        rightButton
      ],
    ),
  );
}