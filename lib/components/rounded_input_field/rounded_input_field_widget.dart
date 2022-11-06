import 'package:flutter/material.dart';
import 'package:promo_app/components/text_field_container/text_field_container_widget.dart';
import 'package:promo_app/theme/theme.dart';


class RoundedTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedTextField({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: AppTheme.kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
