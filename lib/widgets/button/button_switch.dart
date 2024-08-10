import 'package:flutter/material.dart';

class SwitchButton extends StatefulWidget {
  SwitchButton({
    required this.items,
    this.width = 120,
    this.height = 38,
    this.initIdx = 0,
    this.onChange
  });

  double width;
  double height;

  List<String> items;

  int initIdx;

  ValueChanged<int>? onChange;

  @override
  State<StatefulWidget> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  int selectedIdx = 0;

  @override
  void initState() {
    selectedIdx = widget.initIdx;
    super.initState();
  }

  Widget _createItem(int idx) {
    return Flexible(
      flex: 1,
      fit: FlexFit.loose,
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIdx = idx;
          });
          if (widget.onChange != null) {
            widget.onChange!(idx);
          }
        },
        child: Container(
          color: idx == selectedIdx ? Color(0xFF0075FF) : Colors.white,
          child: Center(
            child: Text(
              widget.items[idx],
              style: TextStyle(
                color: idx == selectedIdx ? Colors.white : Colors.black38,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      width: widget.width,
      height: widget.height,
      child: Row(
        children: List.generate(widget.items.length, (idx) => _createItem(idx)),
      ),
    );
  }
}
