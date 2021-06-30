import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FlutterwavePaymentOption extends StatelessWidget {
  final Function handleClick;
  final String buttonText;
  final Widget icon;

  FlutterwavePaymentOption({
    required this.icon,
    required this.handleClick,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      dense: false,
      title: Text(
        buttonText,
        style: TextStyle(color: Colors.black),
      ),
      trailing: Icon(
        FontAwesomeIcons.chevronRight,
        color: Colors.black,
        size: 17,
      ),
      onTap: this._handleClick,
    );

    RaisedButton(
      onPressed: this._handleClick,
      color: Color(0xFFfff1d0),
      child: Container(
        width: double.infinity,
        child: RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            text: "Pay with ",
            style: TextStyle(fontSize: 20, color: Colors.black),
            children: [
              TextSpan(
                text: buttonText,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handleClick() {
    this.handleClick();
  }
}
