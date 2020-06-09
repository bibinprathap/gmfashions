import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:gmfashions/api/models/country_list_response_model.dart';
import 'package:gmfashions/api/models/post_register_details_model.dart'
    as signUp;
import 'package:gmfashions/api/models/state_list_response_model.dart' as state;
import 'package:gmfashions/api/repository.dart';
import 'package:gmfashions/utils/sp_keys.dart';
import 'package:gmfashions/utils/utils.dart';

import '../../main.dart';
import 'add_new_address.dart';

enum AddAddressState { IDLE, LOADING, ERROR }

abstract class AddAddressActivity extends State<AddNewAddress> {
  String name = '',
      lName = '',
      address1 = '',
      address2 = '',
      city = '',
      code = '',
      phone = '',
      countryID = '',
      stateID = '';

  /// formKey
  final formKey = GlobalKey<FormState>();

  List<Response> countryList = [];

  List<state.Response> stateList = [];

  /// Text editing Controller
  TextEditingController countryController = new TextEditingController();
  TextEditingController stateController = new TextEditingController();

  StreamController<AddAddressState> addressCtr =
      StreamController<AddAddressState>();

  void onInitState() {
    getCountry();
  }

  /// country list

  getCountry() async {
    addressCtr.add(AddAddressState.LOADING);
    CountryListResponseModel model = await getCountryList();
    countryList = model.response;
    if (model.success == 1) {
      countryList = model.response;
      addressCtr.add(AddAddressState.IDLE);
    } else {
      addressCtr.add(AddAddressState.ERROR);
    }

  }

  /// onsuggestion selected - Country

  void onSuggestionSelected(country) async {
    //     print('stateid - $country.countryId');
    countryID = country.countryId;
    countryController.text = country.name;
    getState(countryID);
  }

  /// suggestionsCallback - Country

  FutureOr<List<Response>> suggestionsCallback(pattern) async {
    return countryList
        .where((val) => val.name.toLowerCase().contains(pattern.toLowerCase()))
        .toList();
  }

  /// state list

  getState(String countryId) async {
    state.StateListResponseModel stateModel = await getStateList(countryId);
    if (stateModel.success == 1) {
      stateList = stateModel.response;
    } else {
      print('state error');
    }
  }

  ///suggestionSelected - State

  void suggestionSelectedState(state) async {
    //   print('stateid -${state.zoneId}');
    stateID = state.zoneId;
    stateController.text = state.name;
  }

  /// suggestionsCallback - state

  FutureOr<List<state.Response>> stateSuggestionCallback(pattern) async {
    return stateList
        .where((val) => val.name.toLowerCase().contains(pattern.toLowerCase()))
        .toList();
  }

  /// post details
  submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      submitDetails();
    }
  }

  submitDetails() async {
    addressCtr.add(AddAddressState.LOADING);
    var params = {
      'firstname': name,
      'lastname': lName,
      'email': widget.email,
      'telephone': phone,
      'password': widget.password,
      'address_1': address1,
      'address_2': address2,
      'city': city,
      'postcode': code,
      'zone_id': stateID,
      'country_id': countryID,
    };
    print('params - $params');

    signUp.PostRegisterResponseModel model = await postRegisterDetails(params);
    if (model != null) {
            if (model.success == 1) {
              String customerId = model.response[0].customerId.toString();
              String addressId = model.response[0].addressId.toString();

              print('cid - $customerId');
              print('aid - $addressId');
              print('email - ${widget.email}');
              print('email - ${widget.password}');
              print('fname - $name');
              print('lName - $lName');
              print('phone - $phone');

              await Keys.storage.write(key: Keys.customerID, value: customerId);
              await Keys.storage.write(key: Keys.emailID, value: widget.email);
              await Keys.storage.write(key: Keys.addressID, value: addressId);
              await Keys.storage.write(key: Keys.fName, value: name);
              await Keys.storage.write(key: Keys.phoneNumber, value: phone);
              await Keys.storage.write(key: Keys.lastName, value: lName);
              await Keys.storage.write(key: Keys.pass, value: widget.password);

              print('success');
              addressCtr.add(AddAddressState.IDLE);
      //        pushPageTransition(
      //            context: context, pushReplacement: true, toWidget: MyApp());
              RestartWidget.restartApp(context);
            } else {
              addressCtr.add(AddAddressState.ERROR);
            }
    } else {
      addressCtr.add(AddAddressState.ERROR);
    }
   // addressCtr.add(AddAddressState.IDLE);

  }
}
