import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmfashions/api/repository.dart';
import 'package:gmfashions/layouts/order_list/order_list_activity.dart';
import 'package:gmfashions/utils/colors.dart';
import 'package:gmfashions/utils/styles.dart';
import 'package:gmfashions/utils/utils.dart';
import 'package:gmfashions/utils/scale_aware/flutter_scale_aware.dart';
import 'package:gmfashions/widgets/server_error_widget.dart';
import 'package:intl/intl.dart';

class OrderListScreen extends StatefulWidget {
  OrderListScreen({Key key}) : super(key: key);

  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends OrderListActivity {
  @override
  void initState() {
    onInitState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order History',
          style: logoWhiteStyle(context),
        ),
        backgroundColor: red1,
        centerTitle: true,
      ),
      body: StreamBuilder<OrderListChangeState>(
          stream: orderHistoryCtr.stream,
          initialData: OrderListChangeState.LOADING,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case OrderListChangeState.IDLE:
                return orderIdleState();
                break;
              case OrderListChangeState.LOADING:
                return loadingState();
                break;
              case OrderListChangeState.ERROR:
                return ServerErrorWidget();
                break;
              case OrderListChangeState.EMPTY:
                return emptyState(context);
                break;
              default:
                return loadingState();
            }
          }),
    );
  }

  /// order Empty State
  Center emptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.refresh,
            size: 20,
          ),
          SizedBox(
            height: context.scale(10),
          ),
          Text(
            'Order History is Empty',
            style: TextStyle(fontSize: 16, color: grey),
          )
        ],
      ),
    );
  }

  ///loading state
  Center loadingState() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  /// idle state
  Column orderIdleState() {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('Orders History'),
        ),
        Expanded(
          child: ListView.separated(
              itemCount: list.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                String id = list[index].orderId;
                String name = list[index].firstname;
                String price = list[index].total;
                DateTime date = list[index].dateAdded;
                String status = list[index].status;
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: GestureDetector(
                    onTap: (){
                      navigateOrderDetails(id, context, date, status);

                    },
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          child: Text(
                            '#$id',
                            style: TextStyle(color: white),
                          ),
                          backgroundColor: grey,
                          radius: 30,
                        ),
                        SizedBox(
                          width: context.scale(15),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('$name'),
                            SizedBox(
                              height: context.scale(5),
                            ),
                            Text('${DateFormat('dd EEE yyyy').format(date)}'),
                            SizedBox(
                              height: context.scale(5),
                            ),
                            Text(
                                'Total : Rs. ${price.substring(0, price.length - 5)}/-'),
                          ],
                        ),
                        Spacer(),
                        FlatButton(
                          child: Text('$status'),
                          onPressed: () {},
                          textColor: status == 'Pending'
                              ? red1
                              : status == 'Processing' ? green : blue,
                        )
                      ],
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
