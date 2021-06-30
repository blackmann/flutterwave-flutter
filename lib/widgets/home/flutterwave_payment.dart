import 'package:flutter/material.dart';
import 'package:flutterwave/core/bank_transfer_manager/bank_transfer_payment_manager.dart';
import 'package:flutterwave/core/card_payment_manager/card_payment_manager.dart';
import 'package:flutterwave/core/flutterwave_payment_manager.dart';
import 'package:flutterwave/core/mobile_money/mobile_money_payment_manager.dart';
import 'package:flutterwave/core/mpesa/mpesa_payment_manager.dart';
import 'package:flutterwave/core/pay_with_account_manager/bank_account_manager.dart';
import 'package:flutterwave/core/ussd_payment_manager/ussd_manager.dart';
import 'package:flutterwave/core/voucher_payment/voucher_payment_manager.dart';
import 'package:flutterwave/models/responses/charge_response.dart';
import 'package:flutterwave/widgets/bank_account_payment/bank_account_payment.dart';
import 'package:flutterwave/widgets/bank_transfer_payment/bank_transfer_payment.dart';
import 'package:flutterwave/widgets/card_payment/card_payment.dart';
import 'package:flutterwave/widgets/mobile_money/pay_with_mobile_money.dart';
import 'package:flutterwave/widgets/mpesa_payment/pay_with_mpesa.dart';
import 'package:flutterwave/widgets/ussd_payment/pay_with_ussd.dart';
import 'package:flutterwave/widgets/voucher_payment/pay_with_voucher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'flutterwave_payment_option.dart';

class FlutterwaveUI extends StatefulWidget {
  final FlutterwavePaymentManager _flutterwavePaymentManager;

  FlutterwaveUI(this._flutterwavePaymentManager);

  @override
  _FlutterwaveUIState createState() => _FlutterwaveUIState();
}

class _FlutterwaveUIState extends State<FlutterwaveUI> {
  Color dividerColor = Color(0xffD8D8DE);
  Color darkTextAndIcons = Color(0xff0C0B33);

  ScrollController? _controller;
  bool isScrolledToTop = true;
  static const double EMPTY_SPACE = 10.0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _controller = ScrollController();
    _controller!.addListener(_scrollListener);
  }

  _scrollListener() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (_controller!.offset <= _controller!.position.minScrollExtent &&
        _controller!.position.axisDirection == AxisDirection.down) {
      //call setState only when values are about to change
      if (!isScrolledToTop) {
        setState(() {
          //reach the top
          isScrolledToTop = true;
        });
      }
    } else {
      //call setState only when values are about to change
      if (_controller!.offset > EMPTY_SPACE && isScrolledToTop) {
        setState(() {
          //not the top
          isScrolledToTop = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final FlutterwavePaymentManager paymentManager =
        this.widget._flutterwavePaymentManager;

    return MaterialApp(
      debugShowCheckedModeBanner: paymentManager.isDebugMode,
      theme: ThemeData(fontFamily: "Poppins"),
      home: Scaffold(
        backgroundColor: Colors.white,
        key: this._scaffoldKey,
        appBar: AppBar(
            elevation: isScrolledToTop ? 0 : 2,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            title: Text(
              "",
              style: TextStyle(
                fontSize: 17,
                color: darkTextAndIcons,
                fontWeight: FontWeight.w500,
              ),
            )),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                child: Text(
                  "How would you like to pay?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: darkTextAndIcons,
                    fontFamily: "FLW",
                    fontSize: 22.0,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                child: SafeArea(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.white38,
                            width: double.infinity,
                            child: Column(
                              children: [
                                Visibility(
                                  visible: paymentManager.acceptAccountPayment,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        child: FlutterwavePaymentOption(
                                          icon: Icon(
                                              FontAwesomeIcons.moneyCheckAlt,
                                              color: darkTextAndIcons,
                                              size: 20),
                                          handleClick:
                                              this._launchPayWithAccountWidget,
                                          buttonText: "Account",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: paymentManager.acceptCardPayment,
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 1, color: dividerColor),
                                          ),
                                        ),
                                        width: double.infinity,
                                        child: FlutterwavePaymentOption(
                                          icon: Icon(
                                              FontAwesomeIcons.solidCreditCard,
                                              color: darkTextAndIcons,
                                              size: 20),
                                          handleClick:
                                              this._launchCardPaymentWidget,
                                          buttonText: "Card",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: paymentManager.acceptUSSDPayment,
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 1, color: dividerColor),
                                          ),
                                        ),
                                        child: FlutterwavePaymentOption(
                                          icon: Icon(
                                              FontAwesomeIcons.dollarSign,
                                              color: darkTextAndIcons,
                                              size: 20),
                                          handleClick:
                                              this._launchUSSDPaymentWidget,
                                          buttonText: "USSD",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      paymentManager.acceptBankTransferPayment,
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 1, color: dividerColor),
                                          ),
                                        ),
                                        child: FlutterwavePaymentOption(
                                          icon: Icon(
                                              FontAwesomeIcons.university,
                                              color: darkTextAndIcons,
                                              size: 20),
                                          handleClick: this
                                              ._launchBankTransferPaymentWidget,
                                          buttonText: "Bank Transfer",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: paymentManager.acceptMpesaPayment,
                                  child: Column(children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              width: 1, color: dividerColor),
                                        ),
                                      ),
                                      child: FlutterwavePaymentOption(
                                        icon: Container(
                                          height: 40,
                                          child: Image(
                                            image: AssetImage(
                                                "lib/assets/mpesa.png",
                                                package: "flutterwave"),
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                        handleClick:
                                            this._launchMpesaPaymentWidget,
                                        buttonText: "",
                                      ),
                                    ),
                                  ]),
                                ),
                                Visibility(
                                  visible:
                                      paymentManager.acceptRwandaMoneyPayment,
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 1, color: dividerColor),
                                          ),
                                        ),
                                        child: FlutterwavePaymentOption(
                                          icon: Icon(FontAwesomeIcons.mobileAlt,
                                              color: darkTextAndIcons,
                                              size: 20),
                                          handleClick: this
                                              ._launchMobileMoneyPaymentWidget,
                                          buttonText: "Rwanda Mobile Money",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: paymentManager.acceptGhanaPayment,
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 1, color: dividerColor),
                                          ),
                                        ),
                                        child: FlutterwavePaymentOption(
                                          icon: Icon(
                                            FontAwesomeIcons.mobileAlt,
                                            color: darkTextAndIcons,
                                          ),
                                          handleClick: this
                                              ._launchMobileMoneyPaymentWidget,
                                          buttonText: "Ghana Mobile Money",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: paymentManager.acceptUgandaPayment,
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 1, color: dividerColor),
                                          ),
                                        ),
                                        child: FlutterwavePaymentOption(
                                          icon: Icon(FontAwesomeIcons.mobileAlt,
                                              color: darkTextAndIcons,
                                              size: 20),
                                          handleClick: this
                                              ._launchMobileMoneyPaymentWidget,
                                          buttonText: "Uganda Mobile Money",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: paymentManager.acceptZambiaPayment,
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 1, color: dividerColor),
                                          ),
                                        ),
                                        child: FlutterwavePaymentOption(
                                          handleClick: this
                                              ._launchMobileMoneyPaymentWidget,
                                          icon: Icon(FontAwesomeIcons.mobileAlt,
                                              color: darkTextAndIcons,
                                              size: 20),
                                          buttonText: "Zambia Mobile Money",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: false,
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 1, color: dividerColor),
                                          ),
                                        ),
                                        child: FlutterwavePaymentOption(
                                          handleClick: () => {},
                                          buttonText: "Barter",
                                          icon: Icon(FontAwesomeIcons.mobileAlt,
                                              color: darkTextAndIcons,
                                              size: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: paymentManager.acceptVoucherPayment,
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 1, color: dividerColor),
                                          ),
                                        ),
                                        child: FlutterwavePaymentOption(
                                          icon: Icon(FontAwesomeIcons.receipt,
                                              color: darkTextAndIcons,
                                              size: 20),
                                          handleClick:
                                              this._launchVoucherPaymentWidget,
                                          buttonText: "Voucher",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: paymentManager
                                      .acceptFancophoneMobileMoney,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 1, color: dividerColor),
                                      ),
                                    ),
                                    child: FlutterwavePaymentOption(
                                      icon: Icon(
                                        FontAwesomeIcons.mobileAlt,
                                        color: darkTextAndIcons,
                                      ),
                                      handleClick:
                                          this._launchMobileMoneyPaymentWidget,
                                      buttonText: "Francophone Mobile Money",
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchCardPaymentWidget() async {
    final CardPaymentManager cardPaymentManager =
        this.widget._flutterwavePaymentManager.getCardPaymentManager();

    final dynamic response = await Navigator.push(
      this.context,
      MaterialPageRoute(builder: (context) => CardPayment(cardPaymentManager)),
    );
    _handleBackPress(response);
  }

  void _launchPayWithAccountWidget() async {
    final BankAccountPaymentManager bankAccountPaymentManager =
        this.widget._flutterwavePaymentManager.getBankAccountPaymentManager();
    final response = await Navigator.push(
      this.context,
      MaterialPageRoute(
          builder: (context) => PayWithBankAccount(bankAccountPaymentManager)),
    );
    _handleBackPress(response);
  }

  void _launchUSSDPaymentWidget() async {
    final USSDPaymentManager paymentManager =
        this.widget._flutterwavePaymentManager.getUSSDPaymentManager();
    final response = await Navigator.push(
      this.context,
      MaterialPageRoute(builder: (context) => PayWithUssd(paymentManager)),
    );
    _handleBackPress(response);
  }

  void _launchMobileMoneyPaymentWidget() async {
    final MobileMoneyPaymentManager mobileMoneyPaymentManager =
        this.widget._flutterwavePaymentManager.getMobileMoneyPaymentManager();
    final response = await Navigator.push(
      this.context,
      MaterialPageRoute(
          builder: (context) => PayWithMobileMoney(mobileMoneyPaymentManager)),
    );
    _handleBackPress(response);
  }

  void _launchMpesaPaymentWidget() async {
    final FlutterwavePaymentManager paymentManager =
        this.widget._flutterwavePaymentManager;
    final MpesaPaymentManager mpesaPaymentManager =
        paymentManager.getMpesaPaymentManager();
    final response = await Navigator.push(
      this.context,
      MaterialPageRoute(
          builder: (context) => PayWithMpesa(mpesaPaymentManager)),
    );
    _handleBackPress(response);
  }

  void _launchVoucherPaymentWidget() async {
    final VoucherPaymentManager voucherPaymentManager =
        this.widget._flutterwavePaymentManager.getVoucherPaymentManager();
    final response = await Navigator.push(
      this.context,
      MaterialPageRoute(
          builder: (context) => PayWithVoucher(voucherPaymentManager)),
    );
    _handleBackPress(response);
  }

  void _launchBankTransferPaymentWidget() async {
    final BankTransferPaymentManager bankTransferPaymentManager =
        this.widget._flutterwavePaymentManager.getBankTransferPaymentManager();
    final response = await Navigator.push(
      this.context,
      MaterialPageRoute(
          builder: (context) =>
              PayWithBankTransfer(bankTransferPaymentManager)),
    );
    _handleBackPress(response);
  }

  void showSnackBar(String message) {
    SnackBar snackBar = SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
    );
    this._scaffoldKey.currentState!.showSnackBar(snackBar);
  }

  void _handleBackPress(dynamic result) {
    if (result == null || result is ChargeResponse) {
      final ChargeResponse? chargeResponse = result as ChargeResponse;
      String message;
      if (chargeResponse != null) {
        message = chargeResponse.message!;
      } else {
        message = "Transaction cancelled";
      }
      this.showSnackBar(message);
      Navigator.pop(this.context, chargeResponse);
    } else {
      // checking if back arrow was pressed so we do nothing.
    }
  }
}
