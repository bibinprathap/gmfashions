import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gmfashions/api/models/country_list_response_model.dart';
import 'package:gmfashions/api/models/state_list_response_model.dart' as state;
import 'package:gmfashions/utils/colors.dart';
import 'package:gmfashions/utils/styles.dart';
import 'package:gmfashions/utils/utils.dart';
import 'package:gmfashions/widgets/server_error_widget.dart';

import 'add_address_activity.dart';
import 'package:gmfashions/utils/scale_aware/flutter_scale_aware.dart';

class AddAddressScreen extends StatefulWidget {
  AddAddressScreen({Key key}) : super(key: key);

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends AddAddressActivity {
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
      backgroundColor: white,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        elevation: 0,
        backgroundColor: white,
        title: Text(
          'Add Address',
          style: TextStyle(color: black, fontSize: 18),
        ),
        centerTitle: true,

      ),
      body: StreamBuilder<AddAddressState>(
          stream: addressCtr.stream,
          initialData: AddAddressState.IDLE,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case AddAddressState.IDLE:
                return addAddressForm(context);
                break;
              case AddAddressState.LOADING:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case AddAddressState.ERROR:
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

// add address field

  Widget addAddressForm(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
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
              addAddressField('Mobile Number',
                  isMandatory: true, inputType: TextInputType.phone),
              Row(
                children: <Widget>[
                  Expanded(child: countryField()),
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
              addAddressField('Postal Code',
                  isMandatory: true, inputType: TextInputType.phone),
              SizedBox(
                width: context.scale(20),
              ),
              Row(
                children: <Widget>[
                  Text('Set as Default',style: headingTxt(14, context,color: grey),),
                  SizedBox(
                    width: context.scale(10),
                  ),
                  Switch(
                    onChanged: setDefault,
                    value: defaultAddress,
                  )
                ],
              ),
              SizedBox(
                height: context.scale(10),
              ),
//            Spacer(),
              addAddressBtn()
            ],
          ),
        ),
      ),
    );
  }

  // address text field

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
              firstName = val;
              print('first name - $firstName');
              break;
            case 'Last Name':
              lastName = val;
              print('name - $lastName');
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
              postCode = val;
              print('code - $postCode');
              break;
            case 'Mobile Number':
              mobileNumber = val;
              print('phone - $mobileNumber');
              break;
            default:
              print('default');
              break;
          }
        },
        // cursorColor: primaryColor,
        style: inputFieldTextStyle,
        decoration: InputDecoration(
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

  // country field
  Widget countryField() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: TypeAheadFormField<Response>(
          autoFlipDirection: true,
          textFieldConfiguration: TextFieldConfiguration(
            controller: countryController,
            decoration: InputDecoration(
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
          suggestionsCallback: suggestionsCallback),
    );
  }

// state field

  Widget getStateField() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: TypeAheadFormField<state.Response>(
          autoFlipDirection: true,
          textFieldConfiguration: TextFieldConfiguration(
            controller: stateController,
            decoration: InputDecoration(
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
          suggestionsCallback: stateSuggestionCallback),
    );
  }

// add address btn
  SizedBox addAddressBtn() {
    return SizedBox(
        width: double.infinity,
        child: RaisedButton(
          elevation: 3,
          onPressed: () {
            submit();
          },
          child: Text(
            'Submit',
          ),
          color: orange,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ));
  }
}
