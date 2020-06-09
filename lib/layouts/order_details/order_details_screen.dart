import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmfashions/utils/colors.dart';
import 'package:gmfashions/utils/styles.dart';
import 'package:gmfashions/utils/utils.dart';
import 'package:gmfashions/widgets/server_error_widget.dart';
import 'package:intl/intl.dart';

import 'order_details_activity.dart';
import 'package:gmfashions/utils/scale_aware/flutter_scale_aware.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String orderID;
  final DateTime date;
  final String status;

  OrderDetailsScreen({Key key, this.orderID, this.date, this.status})
      : super(key: key);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends OrderDetailsActivity {
  @override
  void initState() {
    onInitState(widget.orderID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: red1,
        title: Text('My Order',style:  logoWhiteStyle(context),),
      ),
      body: StreamBuilder<OrderDetailsChangeState>(
          stream: orderCtr.stream,
          initialData: OrderDetailsChangeState.LOADING,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case OrderDetailsChangeState.IDLE:
                return SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '${DateFormat('dd MMM yyyy').format(widget.date)}',
                              style: TextStyle(fontSize: 16),
                            ),
                            Chip(
                              backgroundColor: orange,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              label: Text(
                                'Order ID: #${widget.orderID}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),

                          ],
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        getTotalList(),
                        Divider(
                          thickness: 2,
                        ),
                        Text(
                          'Orders',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: context.scale(10),
                        ),
                        orderStatusStepper(context),
                        Divider(),
                        Text(
                          'Shipping Address',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: context.scale(10),
                        ),
                        shippingAddress(context),
                        SizedBox(
                          height: context.scale(10),
                        ),
                        Text(
                          'Products',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: context.scale(10),
                        ),
                        products()
                      ],
                    ),
                  ),
                );

                break;
              case OrderDetailsChangeState.LOADING:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case OrderDetailsChangeState.ERROR:
                return ServerErrorWidget();
                break;
              default:
                return Center(
                  child: CircularProgressIndicator(),
                );
            }
          }),
    );
  }

  ListView products() {
    return ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: context.scale(10),
          );
        },
        physics: ScrollPhysics(),
        itemCount: response[0].productDetails.length,
        itemBuilder: (context, index) {
          String img = response[0].productDetails[index].image;
          String productName = response[0].productDetails[index].name;
          String qty = response[0].productDetails[index].quantity;
          int price = response[0].productDetails[index].price;
          return productListItem(context, img, productName, qty, price);
        });
  }

  Row shippingAddress(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: context.scale(80),
          height: context.scale(80),
          child: Image.asset(
            'images/home_icon.jpeg',
            width: context.scale(80),
            height: context.scale(80),
          ),
        ),
        SizedBox(
          width: context.scale(20),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${response[0].orderDetails[0]['payment_firstname']} ${response[0].orderDetails[0]['payment_lastname']}',
                style: headingTxt(14, context, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: context.scale(5),),
              Text(
                '${response[0].orderDetails[0]['payment_address_1']} ${response[0].orderDetails[0]['payment_address_2'].isEmpty ? '' : '${response[0].orderDetails[0]['payment_address_2']}'} ',
                style: headingTxt(
                  14,
                  context,
                  color: grey,
                ),
              ),
              Text(
                '${response[0].orderDetails[0]['payment_city']} -${response[0].orderDetails[0]['payment_postcode']}.',
                style:headingTxt(
                  14,
                  context,
                  color: grey,
                ),
              ),
              Text(
                '${response[0].orderDetails[0]['payment_zone']}, ${response[0].orderDetails[0]['payment_country']}.',
                style:headingTxt(
                  14,
                  context,
                  color: grey,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Stepper orderStatusStepper(BuildContext context) {
    return Stepper(
      physics: ScrollPhysics(),
      controlsBuilder: (BuildContext context,
          {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
        return Row(
          children: <Widget>[
            Container(
              child: null,
            ),
            Container(
              child: null,
            ),
          ],
        );
      },
      steps: [
        stepWidget(context, 'Order Pending', 'We are preparing your order',
            Icons.directions_walk,
            isActive: widget.status == 'Pending' ? true : false,
            stepState: widget.status == 'Pending'
                ? StepState.complete
                : StepState.disabled),
        stepWidget(context, 'Order Processed', 'Your Order hasbeen Processed',
            Icons.directions_bike,
            isActive: widget.status == 'Processing' ? true : false,
            stepState:
                widget.status == 'Processing' && widget.status == 'Pending'
                    ? StepState.complete
                    : StepState.disabled),
        widget.status == 'Canceled'
            ? stepWidget(
                context,
                'Order Cancelled ',
                'We have Cancelled your order',
                Icons.check_circle_outline,
                stepState: widget.status == 'Canceled'
                    ? StepState.error
                    : StepState.disabled,
                isActive: widget.status == 'Cancelled' ? true : false,
              )
            : stepWidget(
                context,
                'Order Delivered',
                'We have delivered your order',
                Icons.check_circle_outline,
                stepState: widget.status == 'Delivered'
                    ? StepState.complete
                    : StepState.disabled,
                isActive: widget.status == 'Delivered' ? true : false,
              )
      ],
    );
  }

  Step stepWidget(
      BuildContext context, String title, subTitle, IconData iconData,
      {StepState stepState, bool isActive}) {
    return Step(
      isActive: isActive,
      state: stepState,
      //state: widget.status == 'Pending'  ? StepState.complete  : widget.status == 'Canceled' ? StepState.error : StepState.disabled ,
      title: Row(
        children: <Widget>[
          Icon(
            iconData,
            size: context.scale(18),
            color: orange,
          ),
          SizedBox(
            width: context.scale(5),
          ),
          Text(
            title,
            style: headingTxt(14, context),
          ),
        ],
      ),
      content: Text(''),
      subtitle: Text(
        subTitle,
        style: disabledText(context, 14),
      ),
    );
  }

  Container productListItem(BuildContext context, String img,
      String productName, String qty, int price) {
    return Container(
      child: Row(
        children: <Widget>[
          SizedBox(
            width: context.scale(100),
            height: context.scale(100),
            child: imageWidget(
              imageURL: img,
              width: context.scale(100),
              height: context.scale(100),
            ),
          ),
          SizedBox(
            width: context.scale(20),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  productName,
                  style: headingTxt(14, context, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: context.scale(5),),
                Text(
                  'Qty - $qty',
                  style: headingTxt(
                    12,
                    context,
                    color: grey,
                  ),
                ),

                SizedBox(height: context.scale(5),),
                Text(
                  'Rs.$price/-',
                  style: headingTxt(14, context,
                      color: red1, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  ListView getTotalList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: response[0].totalDetails.length,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          String title = response[0].totalDetails[index].title;
          String val = response[0]
              .totalDetails[index]
              .value
              .substring(0, response[0].totalDetails[index].value.length - 5);
          return getTotalValue(title, val);
        });
  }

  Padding getTotalValue(String title, String val) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '$title',
          ),
          Text(
            'Rs.$val/-',
          ),
        ],
      ),
    );
  }
}
