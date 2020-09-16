import 'package:flutter/material.dart';
import 'theme.dart';

class CustomButton extends StatelessWidget {
  final Function onPress;
  final String label;
  const CustomButton(this.label, this.onPress);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(70),
          ),
          child: MaterialButton(
            color: Theme.of(context).primaryColor,
            minWidth: double.infinity,
            height: 50,
            onPressed:(){onPress();},
            child: Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
