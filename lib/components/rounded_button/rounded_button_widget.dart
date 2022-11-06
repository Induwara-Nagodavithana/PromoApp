import 'package:flutter/material.dart';
import 'package:promo_app/theme/theme.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final void Function() press;
  final Color color, textColor;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = AppTheme.kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size =
        MediaQuery.of(context).size; // size = total height and width on screen
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: ElevatedButton(

          // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          // color: color,
          onPressed: press,
          child: Text(text,
              style: TextStyle(
                color: textColor,
              )),
        ),
      ),
    );
  }
}

