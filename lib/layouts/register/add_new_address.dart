import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gmfashions/api/models/country_list_response_model.dart';
import 'package:gmfashions/api/models/state_list_response_model.dart' as state;
import 'package:gmfashions/utils/colors.dart';
import 'package:gmfashions/utils/styles.dart';
import 'package:gmfashions/utils/utils.dart';
import 'package:gmfashions/utils/scale_aware/flutter_scale_aware.dart';
import 'package:gmfashions/widgets/server_error_widget.dart';

import 'add_new_address_activty.dart';

class AddNewAddress extends StatefulWidget {
  final String email, password;

  AddNewAddress({Key key, this.password, this.email}) : super(key: key);

  @override
  _AddNewAddressState createState() => _AddNewAddressState();
}

class _AddNewAddressState extends AddAddressActivity {
  @override
  void initState() {
    onInitState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: red1,
        centerTitle: true,
        title: Text('Add Address',style: logoWhiteStyle(context),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                addAddressField('First Name', isMandatory: true),
                addAddressField('Last Name', isMandatory: true),
                addAddressField('Address 1', isMandatory: true),
                addAddressField('Address 2', isMandatory: false),
                addAddressField('Mobile Number', isMandatory: true,inputType: TextInputType.phone),
//              Row(
//                children: <Widget>[
//                  Expanded(
//                      child: addAddressField('City',
//                          isMandatory: true,
//                          iconData: Icons.keyboard_arrow_down)),
//                  SizedBox(
//                    width: context.scale(20),
//                  ),
//                  Expanded(
//                      child: addAddressField('Postal Code',
//                          isMandatory: true,
//                          iconData: Icons.keyboard_arrow_down)),
//                ],
//              ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: countryField(),
                    ),
                    SizedBox(
                      width: context.scale(20),
                    ),
                    Expanded(
                      child: getStateField(),
                    ),
                  ],
                ),
                addAddressField(
                  'City',
                  isMandatory: true,
                ),
                addAddressField(
                  'Postal Code',
                  isMandatory: true,
                  inputType: TextInputType.phone
                ),
                addAddressBtn()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container addAddressField(String hint,
      {TextInputType inputType, bool isMandatory = false, IconData iconData}) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: TextFormField(
        //   onTap: onTap,
        keyboardType: inputType,
        validator: (val) {
          if (isMandatory && val.isEmpty) {
            return 'Please Enter Your $hint';
          }
          return null;
        },
        onSaved: (val) {
          print('hint-$hint');
          print('val-$val');
          switch (hint) {
            case 'First Name':
              name = val;
              print('first name - $name');
              break;
            case 'Last Name':
              lName = val;
              print('name - $lName');
              break;
            case 'Address 1':
              address1 = val;
              print('address1 - $address1');
              break;
            case 'Address 2':
              address2 = val;
              print('address2 - $address2');
              break;
            case 'City':
              city = val;
              print('city - $city');
              break;
            case 'Postal Code':
              code = val;
              print('code - $code');
              break;
            case 'Mobile Number':
              phone = val;
              print('phone - $phone');
              break;
            default:
              print('default');
              break;
          }
        },
        // cursorColor: primaryColor,
        style: inputFieldTextStyle,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          suffixIcon: Icon(
            iconData,
            size: 18,
          ),
          hintText: hint,
          hintStyle: inputFieldHintTextStyle,
        ),
      ),
    );
  }

// country typeahead field

  Widget countryField() {
    return Container(
      margin: EdgeInsets.only(top: 13),
      child: TypeAheadFormField<Response>(
        autoFlipDirection: true,
        textFieldConfiguration: TextFieldConfiguration(
          controller: countryController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            suffixIcon: Icon(
              Icons.keyboard_arrow_down,
              size: 18,
            ),
            hintText: 'Country',
            hintStyle: inputFieldHintTextStyle,
          ),
        ),
        getImmediateSuggestions: true,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please Select Your Country';
          }
          return null;
        },
        onSuggestionSelected: onSuggestionSelected,
        itemBuilder: (context, country) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(country.name),
          );
        },
        suggestionsCallback: suggestionsCallback,
      ),
    );
  }

// state typeahead field

  Widget getStateField() {
    return Container(
      margin: EdgeInsets.only(top: 13),
      child: TypeAheadFormField<state.Response>(
        autoFlipDirection: true,
        textFieldConfiguration: TextFieldConfiguration(
          controller: stateController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            suffixIcon: Icon(
              Icons.keyboard_arrow_down,
              size: 18,
            ),
            hintText: 'State',
            hintStyle: inputFieldHintTextStyle,
          ),
        ),
        getImmediateSuggestions: true,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please Select Your State';
          }
          return null;
        },
        onSuggestionSelected: suggestionSelectedState,
        itemBuilder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(state.name),
          );
        },
        suggestionsCallback: stateSuggestionCallback,
      ),
    );
  }

  // add address btn

  Widget addAddressBtn() {
    return StreamBuilder<AddAddressState>(
      stream: addressCtr.stream,
      builder: (context, snapshot) {
        switch(snapshot.data){
          case AddAddressState.IDLE:
            return SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  elevation: 3,
                  textColor: white,
                  onPressed: () {
                    submit();
                  },
                  child: Text(
                    'Submit',
                  ),
                  color: red1,
                  shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ));
            break;
          case AddAddressState.LOADING:
            return Center(child: CircularProgressIndicator(),);
            break;
          case AddAddressState.ERROR:
            return ServerErrorWidget();
            break;
          default:
            return Center(child: CircularProgressIndicator(),);
            
        }
  
      }
    );
  }
}
