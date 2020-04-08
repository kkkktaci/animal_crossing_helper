import 'package:flutter/material.dart';

Widget wrapWithDirectionality(Widget child) =>
  Directionality(
    textDirection: TextDirection.ltr,
    child: child,
  );

Widget wrapMediaQuery(Widget child) =>
  MediaQuery(
    data: MediaQueryData(size: Size(357, 812)),
    child: child,
  );

Widget wrapMaterialApp(Widget child) =>
  MaterialApp(
    title: 'test',
    home: child,
  );