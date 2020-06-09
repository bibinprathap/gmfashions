import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gmfashions/layouts/dashboard/dashboard_screen.dart';
import 'package:gmfashions/layouts/product_details/product_details.dart';
import 'package:gmfashions/utils/colors.dart';
import 'package:gmfashions/utils/styles.dart';
import 'package:gmfashions/utils/utils.dart';
import 'package:gmfashions/widgets/server_error_widget.dart';

import 'cart_list_activity.dart';
import 'package:gmfashions/utils/scale_aware/flutter_scale_aware.dart';

class CartListScreen extends StatefulWidget {
//  final String customerId;
//  final int price, qty;

  CartListScreen({
    Key key,
  }) : super(key: key);

  @override
  _CartListScreenState createState() => _CartListScreenState();
}

class _CartListScreenState extends CartListActivity {
  @override
  void initState() {
    getCartItemList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'My Cart',
          style: TextStyle(color: black, fontSize: 18),
        ),
        elevation: 0,
        backgroundColor: white,
        iconTheme: IconThemeData(color: black),
      ),
      body: StreamBuilder<CartListState>(
          stream: cartListController.stream,
          initialData: CartListState.LOADING,
          builder: (context, snapshot) {
            print('snapshot - ${snapshot.data}');
            switch (snapshot.data) {
              case CartListState.IDLE:
                return cartListWidget(context);
                break;
              case CartListState.LOADING:
                return loadingWidget(context);
                break;
              case CartListState.EMPTY:
                return cartListEmpty(context);
                break;
              case CartListState.ERROR:
                return ServerErrorWidget();
                break;
              default:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
            }
          }),
    );
  }

// cart list empty State

  Center cartListEmpty(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.remove_shopping_cart,
          size: 60,
          color: grey,
        ),
        SizedBox(
          height: context.scale(20),
        ),
        Text(
          'Your Cart is Empty',
          style: disabledText(context, 18),
        ),
        SizedBox(
          height: context.scale(10),
        ),
        FlatButton.icon(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Dashboard()),
                (Route<dynamic> r) => false);
          },
          label: Text(
            'Add Items to the Cart',
            style: TextStyle(fontSize: 18),
          ),
          icon: Icon(
            Icons.add_shopping_cart,
            color: primaryColor,
          ),
          textColor: primaryColor,
        )
      ],
    ));
  }

  // cart List Widget

  Widget cartListWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
              child: Text(
                'Found ${responseList.length} item${responseList.length == 1 ? '' : 's'} in your Cart',
                style: disabledText(context, 16),
              ),
            ),
          ),
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: responseList.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  int total = responseList[index].total;
                  String cartId = responseList[index].cartId;
                  String img = responseList[index].image;
                  String product = responseList[index].name;
                  int price = responseList[index].price;
                  String qty = responseList[index].quantity;
                  return cartListItem(
                      context, product, qty, total, img, cartId, index);
                }),
          ),
          Divider(),
          totalAmtRow(),
          Divider(),
//          Spacer(),
          proceedBtn(context),
          continueBtn()
        ],
      ),
    );
  }

// continue shopping button

  SizedBox continueBtn() {
    return SizedBox(
        width: double.infinity,
        child: FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Continue Shopping',
            style: btnTxt,
          ),
        ));
  }

// proceed button

  Widget proceedBtn(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: SizedBox(
          width: double.infinity,
          child: RaisedButton(
            elevation: 2,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            onPressed: () {
              navigateAddressScreen(context);
            },
            child: Text(
              'Check Out',
              style: btnTxt,
            ),
            color: orange,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          )),
    );
  }

// cart list Item

  Widget cartListItem(
    BuildContext context,
    String product,
    String qty,
    int total,
    String image,
    String cartId,
    int index,
  ) {
    return GestureDetector(
      onTap: () {},
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        secondaryActions: <Widget>[
          IconSlideAction(
            color: white,
            icon: Icons.delete,
            onTap: () {
              deleteCart(cartId, index, responseList);
            },
            foregroundColor: grey,
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              image == null
                  ? Text(
                      product[0],
                      style: headingTxt(24, context),
                    )
                  : imageWidget(
                      imageURL: image,
                      width: context.scale(100),
                      height: context.scale(100),
                    ),
              SizedBox(
                width: context.scale(20),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product,
                      style: TextStyle(
                          fontSize: 14,
                          color: black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: context.scale(5),
                    ),
                    Text(
                      'Rs.$total /-',
                    ),
                    SizedBox(
                      height: context.scale(10),
                    ),
                    quantityRow(cartId, context, index, qty),
                    SizedBox(
                      height: context.scale(10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // quantity row

  Row quantityRow(
    String id,
    BuildContext context,
    int index,
    String qty,
  ) {
    int quantity = int.parse(qty);
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: responseList[index].option.map((val) {
            return Text('${val.name} - ${val.value}');
          }).toList(),
        ),
        //Text('Size: ${responseList[index].option[index].}'),
        SizedBox(
          width: context.scale(18),
        ),
        Spacer(),
        StreamBuilder<bool>(
            stream: qtnBtnChangeCtr.stream,
            initialData: false,
            builder: (context, snapshot) {
              bool isLoading = snapshot.data;
              print('snapshot - $isLoading');
              return isLoading && currentIndex == index
                  ? CircularProgressIndicator()
                  : Row(
                      children: <Widget>[
                        quantity <= 1
                            ? SizedBox(
                                height: context.scale(30),
                                child: FloatingActionButton(
                                  mini: true,
                                  heroTag: 'qty -$index',
                                  backgroundColor: grey,
                                  shape: CircleBorder(
                                      side: BorderSide(width: 1, color: grey)),
                                  elevation: 0,
                                  onPressed: () {
                                    qtyMinus(id, quantity, index);
                                  },
                                  child: Icon(
                                    Icons.remove,
                                    color: white,
                                    size: context.scale(18),
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: context.scale(30),
                                child: FloatingActionButton(
                                  heroTag: 'remove $index',
                                  mini: true,
                                  backgroundColor: white,
                                  shape: CircleBorder(
                                      side: BorderSide(width: 1, color: grey)),
                                  elevation: 0,
                                  onPressed: () {
                                    qtyMinus(id, quantity, index);
                                  },
                                  child: Icon(
                                    Icons.remove,
                                    color: black,
                                    size: context.scale(18),
                                  ),
                                ),
                              ),
                        Container(
                          //margin: EdgeInsets.only(left: 8, right: 8),
                          child: Text('$qty',
                              style: headingTxt(
                                16,
                                context,
                                fontWeight: FontWeight.w700,
                              )),
                        ),
                        SizedBox(
                          height: context.scale(30),
                          child: FloatingActionButton(
                            heroTag: 'Add $index',
                            mini: true,
                            backgroundColor: white,
                            shape: CircleBorder(
                                side: BorderSide(width: 1, color: grey)),
                            elevation: 0,
                            onPressed: () {
                              quantityPlus(id, quantity, index);
                            },
                            child: Icon(
                              Icons.add,
                              color: black,
                              size: context.scale(18),
                            ),
                          ),
                        ),
                      ],
                    );
            }),
      ],
    );
  }

// Display total amount

  Widget totalAmtRow() {
    return StreamBuilder<ChangeTotalState>(
        stream: totalCtr.stream,
        initialData: ChangeTotalState.LOADING,
        builder: (context, snapshot) {
          print('snap = ${snapshot.data}');
          switch (snapshot.data) {
            case ChangeTotalState.IDLE:
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Total Amount',
                        style: disabledText(context, 18),
                      ),
                    ),
                    Text(
                      'Rs.${totList[0].subTotal}',
                      style:
                          headingTxt(18, context, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              );
              break;
            case ChangeTotalState.LOADING:
              return Center(child: CircularProgressIndicator());
              break;

            case ChangeTotalState.ERROR:
              return ServerErrorWidget();
              break;
            default:
              return Center(child: CircularProgressIndicator());
          }
        });
  }
}
