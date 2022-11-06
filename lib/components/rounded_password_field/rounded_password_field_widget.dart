import 'package:flutter/material.dart';
import 'package:promo_app/components/text_field_container/text_field_container_widget.dart';
import 'package:promo_app/theme/theme.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const RoundedPasswordField({Key? key, required this.onChanged})
      : super(key: key);
  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _obscure = true;
  //ValueChanged<String> onChanged=State().onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: widget.onChanged,
        obscureText: _obscure,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: AppTheme.kPrimaryColor,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscure = !_obscure;
              });
            },
            child: Icon(
              Icons.visibility,
              color: AppTheme.kPrimaryColor,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

// class RoundedPasswordField extends StatelessWidget {
//   final ValueChanged<String> onChanged;
//   const RoundedPasswordField({
//     Key key,
//     this.onChanged,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     bool _obscure = true;
//     return TextFieldContainer(
//       child: TextField(
//         obscureText: _obscure,
//         decoration: InputDecoration(
//           hintText: "Password",
//           icon: Icon(
//             Icons.lock,
//             color: kPrimaryColor,
//           ),
//           suffixIcon: GestureDetector(
//             onTap: () {
//               setState(() {
//                 _obscure = !_obscure;
//               });
//             },
//             child: Icon(
//               Icons.visibility,
//               color: kPrimaryColor,
//             ),
//           ),
//           border: InputBorder.none,
//         ),
//       ),
//     );
//   }
// }

// void setState(Null Function() param0) {}

