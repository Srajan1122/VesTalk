import 'package:flutter/material.dart';

class BottomHelperText extends StatelessWidget {
  const BottomHelperText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text.rich(
              TextSpan(
                text: 'Login with',
                style: TextStyle(fontSize: 15),
                children: <TextSpan>[
                  TextSpan(
                      text: ' VES ',
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold)),
                  TextSpan(text: "ID's only", style: TextStyle()),
                ],
              ),
            )),
      ),
    );
  }
}
