import 'package:flutter/material.dart';

class TermAgreementButton extends StatefulWidget {
  TermAgreementButton({
    required this.isChecked,
    required this.isRequired,
    required this.name,
    required this.content,
    this.onChanged
  });

  bool isChecked;
  bool isRequired;

  String name;
  String content;

  ValueChanged<bool>? onChanged;

  @override
  State<StatefulWidget> createState() => _TermAgreementButtonState();
}

class _TermAgreementButtonState extends State<TermAgreementButton> {
  @override
  Widget build(BuildContext context) {
    String name = '';
    if (widget.isRequired) name += '(필수) ';
    name += widget.name;

    return Padding(
      padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
                activeColor: Color(0xFF4285F4),
                value: widget.isChecked,
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    widget.isChecked = value;
                  });
                  if (widget.onChanged == null) return;
                  widget.onChanged!(value);
                }
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {

              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Colors.black54,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
