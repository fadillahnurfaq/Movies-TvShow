import 'package:flutter/material.dart';

import '../../../utils/constant.dart';

class DetailRowContent extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? iconColor, textColor;
  const DetailRowContent({
    super.key,
    required this.icon,
    required this.title,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.0,
          color: iconColor ?? kGreyBoldColor,
        ),
        kHorizontalSpace(5.0),
        Text(
          title,
          style: TextStyle(color: textColor ?? kGreyBoldColor),
        )
      ],
    );
  }
}
