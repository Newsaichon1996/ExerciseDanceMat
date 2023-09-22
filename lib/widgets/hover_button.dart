import 'package:flutter/material.dart';

class HoverButton extends StatefulWidget {
  const HoverButton({Key? key, this.onTap, this.child, this.size, this.color,})
      : super(key: key);

  final VoidCallback? onTap;
  final Widget? child;
  final Size? size;
  final Color? color;

  @override
  State<HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool _isOver = false;
  double width = 100;
  double hight = 100;

  @override
  void initState() {
    super.initState();
    width = widget.size?.width ?? 100;
    hight = widget.size?.height ?? 100;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          _isOver = true;
        });
      },
      onExit: (event) {
        setState(() {
          _isOver = false;
        });
      },
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          widget.onTap?.call();
        },
        child: AnimatedContainer(
          clipBehavior: Clip.none,
          width: _isOver ? width + 20 : width,
          height: hight,
          curve: Curves.easeInOutCirc,
          padding: const EdgeInsets.all(16),
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
              boxShadow: _isOver
                  ? [
                      BoxShadow(
                          color: widget.color?.withOpacity(0.5) ??
                              Colors.grey.shade300,
                          blurRadius: 16,
                          spreadRadius: 2)
                    ]
                  : null,
              borderRadius: BorderRadius.circular(16),
              color: widget.color ?? const Color.fromARGB(255, 255, 255, 255)),
          duration: const Duration(milliseconds: 100),
          child: widget.child,
        ),
      ),
    );
  }
}
