import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RequestPin extends StatefulWidget {
  RequestPin();

  @override
  _RequestPinState createState() => _RequestPinState();
}

class _RequestPinState extends State<RequestPin> {
  bool isButtonActive = false;
  bool isProcessing = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Scaffold(
            body: Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(20, 70, 20, 50),
              child: Form(
                key: this._formKey,
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        "Please enter your card pin to continue your transaction.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        // margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              isDense: true,
                              prefixIcon: Icon(
                                FontAwesomeIcons.lock,
                                size: 17,
                                color: Colors.black,
                              ),
                              fillColor: Colors.white,
                              hintText: "Pin",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.black54),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  width: 1.1,
                                  style: BorderStyle.solid,
                                  color: Colors.black,
                                ),
                              ),
                              suffixIcon: this
                                          ._pinController
                                          .text
                                          .trim()
                                          .length >
                                      0
                                  ? IconButton(
                                      icon: Icon(Icons.close),
                                      color: Colors.black,
                                      onPressed: () {
                                        this._pinController.clear();
                                        checkPinInput(this._pinController.text);
                                      },
                                    )
                                  : Container(
                                      height: 0,
                                      width: 0,
                                    ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  width: 1,
                                  style: BorderStyle.none,
                                  color: Colors.black,
                                ),
                              )),
                          onChanged: (value) {
                            //hacky but this updates the controler

                            checkPinInput(value);
                          },
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          autocorrect: false,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                          controller: this._pinController,
                          validator: this._pinValidator,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding:
                    EdgeInsets.only(top: 0, bottom: 20, left: 20, right: 20),
                child: Container(
                    height: 50,
                    child: MaterialButton(
                        onPressed: !isProcessing
                            ? isButtonActive
                                ? () {
                                    this._continuePayment();
                                  }
                                : null
                            : null,
                        color: Theme.of(context).primaryColor,
                        disabledColor: Theme.of(context).primaryColorLight,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(9.0)),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: !isProcessing
                                  ? Center(
                                      child: new Text(
                                        "Continue Payment",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  : SpinKitThreeBounce(
                                      size: 20,
                                      color: Colors.white,
                                    ),
                            )
                          ],
                        ))),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void checkPinInput(String pin) {
    if (pin.trim().replaceAll(" ", "").length > 0) {
      setState(() {
        isButtonActive = true;
      });
    } else {
      setState(() {
        isButtonActive = false;
      });
    }
  }

  String? _pinValidator(String? value) {
    return value != null && value.trim().isEmpty ? "Pin is required" : null;
  }

  void _continuePayment() {
    if (this._formKey.currentState!.validate()) {
      Navigator.of(this.context).pop(this._pinController.value.text);
    }
  }
}
