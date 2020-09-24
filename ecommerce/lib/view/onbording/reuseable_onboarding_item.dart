import 'package:flutter/material.dart';

class ReusableOnboardingItem extends StatelessWidget {
  final String imageName, title, body;

  const ReusableOnboardingItem({
    @required this.imageName,
    @required this.title,
    @required this.body,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Image.asset(
            this.imageName,
            height: MediaQuery.of(context).size.height * .4,
            width: MediaQuery.of(context).size.width * .75,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            this.title.toUpperCase(),
            style: TextStyle(
              color: Colors.blueGrey,
              fontFamily: 'hind',
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            this.body,
            style: TextStyle(
              color: Colors.blueGrey,
              fontFamily: 'hind',
              fontSize: 17,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .15,
        )
      ],
    );
  }
}
