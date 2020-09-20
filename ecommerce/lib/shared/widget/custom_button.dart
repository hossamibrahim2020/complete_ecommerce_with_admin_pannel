import 'package:flutter/material.dart';
import '../theme.dart';

class CustomRadiusButton extends StatelessWidget {
  final Function onpress;
  final String label;
  final Color color;

  const CustomRadiusButton({
    @required this.onpress,
    @required this.label,
    @required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlatButton(
        onPressed: () {
          onpress();
        },
        child: Container(
          child: Center(
            child: Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: textColor),
            ),
          ),
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}
