import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmfashions/layouts/payment/payment_activity.dart';
import 'package:gmfashions/utils/colors.dart';
import 'package:gmfashions/utils/styles.dart';
import 'package:gmfashions/utils/utils.dart';
import 'package:gmfashions/widgets/server_error_widget.dart';
import 'package:gmfashions/utils/scale_aware/flutter_scale_aware.dart';

class PaymentScreen extends StatefulWidget {
  PaymentScreen({Key key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends PaymentActivity {
  @override
  void initState() {
    onInitState();
    super.initState();
  }

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment',
          style: logoWhiteStyle(context),
        ),
        backgroundColor: red1,
        centerTitle: true,
      ),
      body: StreamBuilder<GetTotalState>(
        initialData:GetTotalState.LOADING,
          stream: totalCtr.stream,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case GetTotalState.IDLE:
                return idleState(context);
                break;
              case GetTotalState.LOADING:
                return loadingWidget(context);
                break;
              case GetTotalState.ERROR:
                return ServerErrorWidget();
                break;
              default:
                return Center(child: CircularProgressIndicator(),);
            }
          }),
    );
  }

  Padding idleState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          getTotal(context),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Text(
                  'Net Banking',
                  style: headingTxt(
                    16,
                    context,
                  ),
                ),
                SizedBox(
                  width: context.scale(5),
                ),
                StreamBuilder<bool>(
                  stream: netBankingSwitchCntlr.stream,
                  initialData: false,
                  builder: (context, snapshot) {
                    return Switch(
                      value: snapshot.data,
                      onChanged: valueChange,
                    );
                  }
                )
              ],
            ),
          ),
          Spacer(),
          StreamBuilder<bool>(
              stream: payBtnCtr.stream,
              initialData: false,
              builder: (context, snapshot) {
                bool isLoading = snapshot.data;
                print('loading - $isLoading');
    
                return isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          child: Text('Pay'),
                          color: orange,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20)),
                          onPressed: () {
                            payBtn();
    
    //                            checkOutOrder(totalList[0].total.toString());
                          },
                        ),
                      );
              })
        ],
      ),
    );
  }

  /// get total

  SizedBox getTotal(BuildContext context) {
    return SizedBox(
      height: context.scale(130),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(
                height: context.scale(5),
              ),
              Text(
                '${totalList[0].qty} Items',
                style: headingTxt(14, context, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: context.scale(15),
              ),
              getTotalRow(context, 'Subtotal :', 'Rs.${totalList[0].subTotal}'),
              SizedBox(
                height: context.scale(5),
              ),
              getTotalRow(context, 'Delivery Charge :',
                  'Rs. ${totalList[0].shippingCharge}'),
              SizedBox(
                height: context.scale(5),
              ),
              getTotalRow(context, 'Order Total :',
                  'Rs.${totalList.elementAt(0).total}'),
            ],
          ),
        ),
      ),
    );
  }

  /// total text
  Row getTotalRow(BuildContext context, String type, String amt) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          type,
          style: headingTxt(14, context),
        ),
        Text(
          amt,
          style: headingTxt(14, context, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
