import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gmfashions/api/models/address_list_model.dart';
import 'package:gmfashions/api/models/country_list_response_model.dart'
    as country;
import 'package:gmfashions/api/models/state_list_response_model.dart' as state;
import 'package:gmfashions/utils/colors.dart';
import 'package:gmfashions/utils/styles.dart';
import 'package:gmfashions/utils/utils.dart';
import 'package:gmfashions/widgets/server_error_widget.dart';

import 'edit_address_activity.dart';
import 'package:gmfashions/utils/scale_aware/flutter_scale_aware.dart';

class EditAddressScreen extends StatefulWidget {
  final Response model;
  final bool isDefault;

  EditAddressScreen({Key key, this.model,this.isDefault}) : super(key: key);

  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends EditAddressActivity {
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
          'Edit Address',
          style: TextStyle(color: black, fontSize: 18),
        ),
        centerTitle: true,

      ),
      body: StreamBuilder<EditAddressState>(
          initialData: EditAddressState.IDLE,
          stream: editAddressCtr.stream,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case EditAddressState.IDLE:
                return editAddressForm(context);
                break;
              case EditAddressState.LOADING:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case EditAddressState.ERROR:
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

// Edit Form

  Widget editAddressForm(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              addAddressField('First Name', widget.model.firstname,
                  isMandatory: true),
              addAddressField('Last Name', widget.model.lastname,
                  isMandatory: true),
              addAddressField('Address 1', widget.model.address1,
                  isMandatory: true),
              addAddressField('Address 2', widget.model.address2,
                  isMandatory: false),
              addAddressField('Mobile Number', widget.model.telephone,
                  isMandatory: true,inputType: TextInputType.phone),
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
                widget.model.city,
                isMandatory: true,
              ),
              addAddressField('Postal Code', widget.model.postcode,
                  isMandatory: true, inputType: TextInputType.phone),
              SizedBox(
                height: context.scale(10),
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
              editAddressBtn()
            ],
          ),
        ),
      ),
    );
  }

  // edit address text field

  Container addAddressField(String hint, String initialValue,
      {TextInputType inputType, bool isMandatory = false, IconData iconData}) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: TextFormField(
        //   onTap: onTap,
        keyboardType: inputType,
        initialValue: initialValue,
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
      child: TypeAheadFormField<country.Response>(
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
  SizedBox editAddressBtn() {
    return SizedBox(
        width: double.infinity,
        child: RaisedButton(
          elevation: 3,
          onPressed: () {
            saveChanges(widget.model.addressId);
          },
          child: Text(
            'Save Changes',
          ),
          color: orange,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ));
  }
}
