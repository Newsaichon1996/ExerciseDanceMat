import 'package:flutter/material.dart';

class Padtable extends StatefulWidget {
  const Padtable({
    Key? key,
    this.child,
    this.color,
  }) : super(key: key);
  final Widget? child;
  final Color? color;

  @override
  State<Padtable> createState() => _PadtableState();
}

class _PadtableState extends State<Padtable> {
  // width
  // double width = 160;
  // double height = 60;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
        decoration: ShapeDecoration(
          color: Colors.lightGreen.shade100,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
              side: const BorderSide(color: Colors.black, width: 2)),
        ),
        child: widget.child);
  }
}
