import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key? key, required this.icon}) : super(key: key);

  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [icon],
      ),
    );
  }
}
