import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:gmfashions/api/models/add_to_Cart_res_model.dart';
import 'package:gmfashions/api/repository.dart';
import 'package:gmfashions/utils/sp_keys.dart';

import 'edit_address_screen.dart';
import 'package:gmfashions/api/models/country_list_response_model.dart';
import 'package:gmfashions/api/models/state_list_response_model.dart' as state;

enum EditAddressState { IDLE, LOADING, ERROR }

abstract class EditAddressActivity extends State<EditAddressScreen> {
  String firstName = '',
      lastName = '',
      mobileNumber = '',
      address1 = '',
      address2 = '',
      city = '',
      postCode = '',
      stateID = '',
      countryID = '';
  bool defaultAddress = false;

  // formKey

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Text editing Controller

  TextEditingController countryController;
  TextEditingController stateController;

  List<Response> countryList = [];

  List<state.Response> stateList = [];

// addressController

  StreamController<EditAddressState> editAddressCtr =
      StreamController<EditAddressState>();

  onInitState() {
    countryController =
        new TextEditingController(text: widget.model.countryName);
    stateController = new TextEditingController(text: widget.model.zoneName);
    defaultAddress = widget.isDefault;
    getCountry();
  }

  onDispose() {
    countryController.dispose();
    stateController.dispose();
  }

  setDefault(bool val){
    defaultAddress = val;
    editAddressCtr.add(EditAddressState.IDLE);

  }

  /// country list

  getCountry() async {
    editAddressCtr.add(EditAddressState.LOADING);
    CountryListResponseModel model = await getCountryList();
    countryList = model.response;
    if (model.success == 1) {
      countryList = model.response;
      editAddressCtr.add(EditAddressState.IDLE);
    } else {
      editAddressCtr.add(EditAddressState.ERROR);
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

  saveChanges(String addressId) {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      postDetails(addressId);
    }
  }

  void postDetails(String addressId) async {
    editAddressCtr.add(EditAddressState.LOADING);
    String email = await storage.read(key: Keys.emailID);
    print('email - $email');
    String customerId = await storage.read(key: Keys.customerID);
    print('customerId - $customerId');
    print('email - $email');
    Map<String, String> params = {
      'customer_id': customerId,
      'address_id': widget.model.addressId,
      'firstname': firstName,
      'lastname': lastName,
      'email': email,
      'telephone': mobileNumber,
      'address_1': address1,
      'address_2': address2,
      'city': city,
      'postcode': postCode,
      'zone_id': stateID,
      'country_id': countryID,
      'default_address': defaultAddress ? '1' : '0',
    };
    print('params - $params');

    AddToCartResponseModel model = await updateAddress(params);
    if (model != null) {
      if (model.success == 1) {
        print('Successfully Update');
        editAddressCtr.add(EditAddressState.IDLE);
      } else {
        print('Post error');
        editAddressCtr.add(EditAddressState.ERROR);
      }
    } else {
      print('Post Json decode error');
      editAddressCtr.add(EditAddressState.ERROR);
    }
  }
}
