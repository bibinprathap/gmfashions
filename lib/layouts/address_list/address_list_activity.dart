import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmfashions/api/models/add_to_Cart_res_model.dart';
import 'package:gmfashions/api/models/address_list_model.dart';
import 'package:gmfashions/api/models/make_default_address_model.dart';
import 'package:gmfashions/api/repository.dart';
import 'package:gmfashions/layouts/addaddress/add_address_screen.dart';
import 'package:gmfashions/layouts/editAddress/edit_address_screen.dart';
import 'package:gmfashions/layouts/payment/payment_screen.dart';
import 'package:gmfashions/utils/sp_keys.dart';
import 'package:gmfashions/utils/utils.dart';

import 'address_list_screen.dart';

enum AddressListChangeState { IDLE, LOADING, ERROR, EMPTY }

abstract class AddressListActivity extends State<AddressListScreen> {
  List<Response> list = [];
  String addressId = '';

  StreamController<AddressListChangeState> addressCtr =
      StreamController<AddressListChangeState>();

  /// onInitState

  onInitState() {
    addressList();
  }

  /// fetch address list
  addressList() async {
    addressCtr.add(AddressListChangeState.LOADING);
    AddressListModel model = await getAddressList();
    if (model != null) {
      if (model.response.isNotEmpty) {
        list = model.response;
        addressId = await Keys.storage.read(key: Keys.addressID);
        print('address List aID - $addressId');
        addressCtr.add(AddressListChangeState.IDLE);
      } else {
        addressCtr.add(AddressListChangeState.EMPTY);
      }
    } else {
      addressCtr.add(AddressListChangeState.ERROR);
    }
  }

  /// navigate edit address
  navigateEditAddressScreen(Response model,int index,bool isDefault) {
//    push(
//        context: context,
//        pushReplacement: false,
//        toWidget: EditAddressScreen());
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditAddressScreen(
                  model: model,
                isDefault: isDefault,
                ))).then((val) {
      addressList();
    });
  }

  /// delete address
  deleteAddressList(int index, String addressId) async {
    Navigator.pop(context);
    AddToCartResponseModel model = await removeAddress(addressId);
    if (model != null) {
      if (model.response == true) {
        list.removeAt(index);
        print('Success');
        addressCtr.add(AddressListChangeState.IDLE);
      } else {
        print('error from delete address ');
        addressCtr.add(AddressListChangeState.ERROR);
      }
    } else {
      print('Json decode error');
      addressCtr.add(AddressListChangeState.ERROR);
    }
  }

  /// make address default
  defaultAddress(String addressId) async {
//    addressCtr.add(AddressListChangeState.LOADING);
    print('aid - $addressId');
    Navigator.pop(context);
    MakeDefaultResponseModel model = await setDefaultAddress(addressId);
    if (model.response == 1) {
      await storage.write(key: Keys.addressID, value: addressId);
      addressList();
      print('changed into default address');
      addressCtr.add(AddressListChangeState.IDLE);
    } else {
      print('Error');
      Navigator.pop(context);
      addressCtr.add(AddressListChangeState.ERROR);
    }
  }

  navigatePaymentScreen(BuildContext context) {
    push(context: context, pushReplacement: false, toWidget: PaymentScreen());
  }

  addAddressScreen() {
//    push(context: context, pushReplacement: false, toWidget: AddAddressScreen());
    Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddAddressScreen()))
        .then((val) {
      addressList();
    });
  }
}
