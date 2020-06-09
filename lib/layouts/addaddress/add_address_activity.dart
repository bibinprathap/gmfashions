import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:gmfashions/api/models/add_address_model.dart' as address;
import 'package:gmfashions/api/models/country_list_response_model.dart';
import 'package:gmfashions/api/models/state_list_response_model.dart' as state;
import 'package:gmfashions/api/repository.dart';
import 'package:gmfashions/utils/sp_keys.dart';

import 'add_address_screen.dart';

enum AddAddressState { IDLE, LOADING, ERROR }

abstract class AddAddressActivity extends State<AddAddressScreen> {

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


  List<Response> countryList = [];

  List<state.Response> stateList = [];

  // Text editing Controller

  TextEditingController countryController = new TextEditingController();
  TextEditingController stateController = new TextEditingController();

// addressController

  StreamController<AddAddressState> addressCtr = StreamController<
      AddAddressState>();
//  final btnCtr = StreamController<bool>();


  void onInitState() {
    getCountry();
  }

  void onDispose() {
    countryController.dispose();
    stateController.dispose();
  }
    setDefault(bool val){
       defaultAddress = val;
       addressCtr.add(AddAddressState.IDLE);

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

  submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      submitDetails();
    }
//    addressCtr.add(AddAddressState.IDLE);
  }

  /// post details

  submitDetails() async {
    addressCtr.add(AddAddressState.LOADING);
    String cId = await Keys.storage.read(key: Keys.customerID);
    String email = await Keys.storage.read(key: Keys.emailID);
    var params = {
      'customer_id': cId,
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
      'country': countryController.text,
      'default_address': defaultAddress ? '1' : '0',
    };
    print('params - $params');
    address.AddAddressResponseModel model = await addAddress(params);
    if (model != null) {
      if (model.success == 1) {
        if (defaultAddress) {
          String addId = model.response[0].addressId.toString();
          print('address_id - $addId');
          await storage.write(key: Keys.addressID, value: addId);
        }
        print('Success');
        Navigator.pop(context);
        addressCtr.add(AddAddressState.IDLE);
      } else {
        print('Error');
        addressCtr.add(AddAddressState.ERROR);
      }
    } else {
      print('Json Error');
      addressCtr.add(AddAddressState.ERROR);
    }
  }

}


