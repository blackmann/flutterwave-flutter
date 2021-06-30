import 'package:flutter/material.dart';
import 'package:flutterwave/models/requests/charge_card/charge_request_address.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RequestAddress extends StatefulWidget {
  @override
  _RequestAddressState createState() => _RequestAddressState();
}

class _RequestAddressState extends State<RequestAddress> {
  bool isPayButtonActive = false;
  bool isProcessing = false;
  final _addressFormKey = GlobalKey<FormState>();

  final TextEditingController _addressFieldController = TextEditingController();
  final TextEditingController _cityFieldController = TextEditingController();
  final TextEditingController _stateFieldController = TextEditingController();
  final TextEditingController _zipCodeFieldController = TextEditingController();
  final TextEditingController _countryFieldController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    this._addressFieldController.dispose();
    this._cityFieldController.dispose();
    this._stateFieldController.dispose();
    this._zipCodeFieldController.dispose();
    this._countryFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        // toolbarHeight: 0,
        title: Text(
          "Enter your billing address details",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => null),
      ),
      body: Scaffold(
        body: Container(
          // padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: _addressFormKey,
            child: Container(
              // margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              isDense: true,
                              fillColor: Colors.white,
                              labelText: "Address",
                              hintText: "Address e.g 10, Lincoln boulevard",
                              hintStyle: TextStyle(
                                  fontSize: 18, color: Colors.black54),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  width: 1.1,
                                  style: BorderStyle.solid,
                                  color: Colors.black,
                                ),
                              ),
                              suffixIcon: this
                                          ._addressFieldController
                                          .text
                                          .trim()
                                          .length >
                                      0
                                  ? IconButton(
                                      icon: Icon(Icons.close),
                                      color: Colors.black,
                                      onPressed: () {
                                        this._addressFieldController.clear();
                                        checkTextInput(
                                            this._addressFieldController.text);
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
                          onChanged: (input) {
                            checkTextInput(input);
                          },
                          controller: this._addressFieldController,
                          validator: (value) =>
                              value != null && value.isNotEmpty
                                  ? null
                                  : "Address is required",
                          // onChanged: ,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              isDense: true,
                              fillColor: Colors.white,
                              labelText: "City",
                              hintText: "City e.g Chicago",
                              hintStyle: TextStyle(
                                  fontSize: 18, color: Colors.black54),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  width: 1.1,
                                  style: BorderStyle.solid,
                                  color: Colors.black,
                                ),
                              ),
                              suffixIcon:
                                  this._cityFieldController.text.trim().length >
                                          0
                                      ? IconButton(
                                          icon: Icon(Icons.close),
                                          color: Colors.black,
                                          onPressed: () {
                                            this._cityFieldController.clear();
                                            checkTextInput(
                                                this._cityFieldController.text);
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
                          onChanged: (input) {
                            checkTextInput(input);
                          },
                          // decoration: InputDecoration(
                          //   labelText: "City",
                          //   hintText: "City e.g Chicago",
                          // ),
                          controller: this._cityFieldController,
                          validator: (value) =>
                              value != null && value.isNotEmpty
                                  ? null
                                  : "City is required",
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              isDense: true,
                              fillColor: Colors.white,
                              labelText: "State",
                              hintText: "State e.g Illinois",
                              hintStyle: TextStyle(
                                  fontSize: 18, color: Colors.black54),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  width: 1.1,
                                  style: BorderStyle.solid,
                                  color: Colors.black,
                                ),
                              ),
                              suffixIcon: this
                                          ._stateFieldController
                                          .text
                                          .trim()
                                          .length >
                                      0
                                  ? IconButton(
                                      icon: Icon(Icons.close),
                                      color: Colors.black,
                                      onPressed: () {
                                        this._stateFieldController.clear();
                                        checkTextInput(
                                            this._stateFieldController.text);
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
                          onChanged: (input) {
                            checkTextInput(input);
                          },
                          // decoration: InputDecoration(
                          //   labelText: "State",
                          //   hintText: "State e.g Illinois",
                          // ),
                          controller: this._stateFieldController,
                          validator: (value) =>
                              value != null && value.isNotEmpty
                                  ? null
                                  : "State is required",
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              isDense: true,
                              fillColor: Colors.white,
                              labelText: "Zipcode",
                              hintText: "Zipcode e.g 1002293",
                              hintStyle: TextStyle(
                                  fontSize: 18, color: Colors.black54),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  width: 1.1,
                                  style: BorderStyle.solid,
                                  color: Colors.black,
                                ),
                              ),
                              suffixIcon: this
                                          ._zipCodeFieldController
                                          .text
                                          .trim()
                                          .length >
                                      0
                                  ? IconButton(
                                      icon: Icon(Icons.close),
                                      color: Colors.black,
                                      onPressed: () {
                                        this._zipCodeFieldController.clear();
                                        checkTextInput(
                                            this._zipCodeFieldController.text);
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
                          onChanged: (input) {
                            checkTextInput(input);
                          },
                          // decoration: InputDecoration(
                          //   labelText: "Zipcode",
                          //   hintText: "Zipcode e.g 1002293",
                          // ),
                          controller: this._zipCodeFieldController,
                          validator: (value) =>
                              value != null && value.isNotEmpty
                                  ? null
                                  : "Zipcode is required",
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              isDense: true,
                              fillColor: Colors.white,
                              labelText: "Country",
                              hintText: "Country e.g Ghana",
                              hintStyle: TextStyle(
                                  fontSize: 18, color: Colors.black54),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  width: 1.1,
                                  style: BorderStyle.solid,
                                  color: Colors.black,
                                ),
                              ),
                              suffixIcon: this
                                          ._countryFieldController
                                          .text
                                          .trim()
                                          .length >
                                      0
                                  ? IconButton(
                                      icon: Icon(Icons.close),
                                      color: Colors.black,
                                      onPressed: () {
                                        this._countryFieldController.clear();
                                        checkTextInput(
                                            this._countryFieldController.text);
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
                          onChanged: (input) {
                            checkTextInput(input);
                          },
                          controller: this._countryFieldController,
                          validator: (value) =>
                              value != null && value.isNotEmpty
                                  ? null
                                  : "Country is required",
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 0, bottom: 20, left: 20, right: 20),
            child: Container(
                height: 50,
                child: MaterialButton(
                    onPressed: () {
                      this._onAddressFilled();
                    },
                    color: Theme.of(context).primaryColor,
                    disabledColor: Theme.of(context).primaryColorLight,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(9.0)),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Center(
                            child: new Text(
                              "Continue",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      ],
                    ))),
          ),
        ),
      ),
    );
  }

  void checkTextInput(String string) {}

  void _onAddressFilled() {
    if (this._addressFormKey.currentState!.validate()) {
      Map<String, String> addressValue = Map<String, String>();
      addressValue["address"] = this._addressFieldController.text;
      addressValue["city"] = this._cityFieldController.text;
      addressValue["state"] = this._stateFieldController.text;
      addressValue["country"] = this._countryFieldController.text;
      addressValue["zipcode"] = this._zipCodeFieldController.text;
      return Navigator.of(this.context)
          .pop(ChargeRequestAddress.fromJson(addressValue));
    }
  }
}
