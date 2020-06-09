import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gmfashions/api/models/address_list_model.dart';
import 'package:gmfashions/utils/colors.dart';
import 'package:gmfashions/utils/styles.dart';
import 'package:gmfashions/utils/utils.dart';
import 'package:gmfashions/widgets/server_error_widget.dart';

import 'address_list_activity.dart';
import 'package:gmfashions/utils/scale_aware/flutter_scale_aware.dart';

class AddressListScreen extends StatefulWidget {
  final bool isDrawer;
  AddressListScreen({Key key,this.isDrawer}) : super(key: key);

  @override
  _AddressListScreenState createState() => _AddressListScreenState();
}

class _AddressListScreenState extends AddressListActivity {
  @override
  void initState() {
    onInitState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        iconTheme: IconThemeData(color: black),
        elevation: 0,
        title: Text('${widget.isDrawer ? 'Address' : 'Delivery'}',style:  logoWhiteStyle(context),),
        centerTitle: true,
        backgroundColor: red1,
      ),
      body: StreamBuilder<AddressListChangeState>(
          stream: addressCtr.stream,
          initialData: AddressListChangeState.LOADING,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case AddressListChangeState.IDLE:
                return idleState(context);
                break;
              case AddressListChangeState.LOADING:
                return loadingState();
                break;
              case AddressListChangeState.ERROR:
                return ServerErrorWidget();
                break;
              case AddressListChangeState.EMPTY:
                return Center(
                  child: Text('Address List Empty'),
                );
                break;
              default:
                return loadingState();
            }
          }),
      floatingActionButton: FloatingActionButton(
        heroTag: 'Add Address ',
        elevation: 0,
        onPressed: () {
          addAddressScreen();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Padding idleState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: context.scale(5),
          ),
          Text('Shipping Address', style: headingTxt(18, context,)),
          SizedBox(
            height: context.scale(20),
          ),
          ListView.separated(
            physics: BouncingScrollPhysics(),
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: context.scale(10),
                );
              },
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                String address = list[index].address1;
                String address2 = list[index].address2;
                String country = list[index].countryName;
                String state = list[index].zoneName;
                String city = list[index].city;
                String code = list[index].postcode;
                String name = list[index].firstname;
                String lName = list[index].lastname;
                String aID = list[index].addressId;
                String phone = list[index].telephone;
                print('aId - $aID');
                print('addressId - $addressId');
                return aID == addressId
                    ? defaultAddressContainer(
                    context,
                    name,
                    address,
                    address2,
                    city,
                    code,
                    state,
                    country,
                    aID,
                    index,list)
                    : addressContainer(
                    context,
                    name,
                    address,
                    address2,
                    city,
                    code,
                    state,
                    country,
                    aID,
                    index,list);
              }),

        ],
      ),
    );
  }

  /// address Container

  Container addressContainer(BuildContext context,
      String name,
      String address,
      String address2,
      String city,
      String code,
      String state,
      String country,
      String aID,
      int index,
      List<Response> aList) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: grey),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: <Widget>[
          Image.asset(
            'images/home_icon.jpeg',
            height: context.scale(60),
            width: context.scale(70),
          ),
          SizedBox(
            width: context.scale(15),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$name',
                style: headingTxt(14, context,fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: context.scale(5),
              ),
              Text(
                '$address ${address2.isEmpty
                    ? ''
                    : address2}, \n$city -$code., \n$state, $country.',
                style: headingTxt(12, context,),
              ),
            ],
          ),
          Spacer(),
          IconButton(
            onPressed: () {
              //                            defaultBottomSheet(context);
              addressBottomSheet(context, aID, index,aList);
            },
            icon: Icon(Icons.more_vert),
          )
        ],
      ),
    );
  }

  /// default address container
  Container defaultAddressContainer(BuildContext context,
      String name,
      String address,
      String address2,
      String city,
      String code,
      String state,
      String country,
      String aId,
      int index,List<Response> aList) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: grey),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
            child: Text(
              'DEFAULT ADDRESS',
              style: TextStyle(fontSize: 12, color: red1),
            ),
          ),
          SizedBox(
            height: context.scale(5),
          ),
          Row(
            children: <Widget>[
              Image.asset(
                'images/map.png',
                height: context.scale(60),
                width: context.scale(70),
              ),
              SizedBox(
                width: context.scale(15),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '$name',
                    style: headingTxt(14, context,fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: context.scale(5),
                  ),
                  Text(
                    '$address ${address2.isEmpty
                        ? ''
                        : address2}, \n$city -$code., \n$state, $country.',
                    style: headingTxt(12, context),
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  defaultBottomSheet(context, index,aId,aList);
                },
                icon: Icon(Icons.more_vert),
              )
            ],
          ),
          SizedBox(
            height: context.scale(5),
          ),
          widget.isDrawer ? Container() :  SizedBox(
            width: double.infinity,
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: orange,
                onPressed: () {
                  navigatePaymentScreen(context);
                },
                child: Text('Payment', style: headingTxt(14, context),),
                textColor: black

            ),
          ) ,
          Container(),
          SizedBox(
            height: context.scale(5),
          ),
        ],
      ),
    );
  }

  void addressBottomSheet(BuildContext context, String addressId, int index,List<Response> aList) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    navigateEditAddressScreen(list[index],index,false);
                  },
                  child: Text(
                    'Edit',
                    style: headingTxt(
                      16,
                      context,
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                FlatButton(
                  onPressed: () {
                    deleteAddressList(index,addressId);
                  },
                  child: Text('Delete',
                      style: headingTxt(16, context, color: red1)),
                ),
                Divider(
                  thickness: 1,
                ),
                FlatButton(
                  onPressed: () {
                    defaultAddress(addressId);
                  },
                  child: Text('Set as Default',
                      style: headingTxt(16, context, color: blue)),
                )
              ],
            ),
            height: context.scale(250),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
          );
        });
  }

  void defaultBottomSheet(BuildContext context, int index,String addressId,List<Response> aList) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    navigateEditAddressScreen(list[index],index,true);
                  },
                  child: Text(
                    'Edit',
                    style: headingTxt(
                      16,
                      context,
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                FlatButton(
                  onPressed: () {
                    deleteAddressList(index,addressId);
                  },
                  child: Text('Delete',
                      style: headingTxt(16, context, color: red1)),
                ),
              ],
            ),
            height: context.scale(150),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
          );
        });
  }

  Widget loadingState() {
    return loadingWidget(context);
  }
}
