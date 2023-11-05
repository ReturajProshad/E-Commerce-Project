import 'package:crafty_bay_app/data/models/Profile_model.dart';
import 'package:crafty_bay_app/data/models/network_response.dart';
import 'package:crafty_bay_app/data/utility/urls.dart';
import 'package:crafty_bay_app/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:crafty_bay_app/presentation/ui/utility/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../data/services/network_caller.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({Key? key, this.comeform}) : super(key: key);
  final ProfileModel? comeform;

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Define text controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _postcodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _receiverNameController = TextEditingController();
  final TextEditingController _receiverContact = TextEditingController();
  final TextEditingController _shippingAddressController =
      TextEditingController();
  String successMessage = "Create";
  @override
  void initState() {
    super.initState();
    if (widget.comeform != null) {
      _nameController.text = widget.comeform!.data!.cusName!;
      _addressController.text = widget.comeform!.data!.cusAdd!;
      _cityController.text = widget.comeform!.data!.cusCity!;
      _stateController.text = widget.comeform!.data!.cusState!;
      _postcodeController.text = widget.comeform!.data!.cusPostcode!;
      _countryController.text = widget.comeform!.data!.cusCountry!;
      _phoneController.text = widget.comeform!.data!.cusPhone!;
      _receiverNameController.text = widget.comeform!.data!.shipName!;
      _receiverContact.text = widget.comeform!.data!.shipPhone!;
      _shippingAddressController.text = widget.comeform!.data!.shipAdd!;
      successMessage = "Update";
    }
  }

  // Function to send user's profile data to the server
  Future<void> completeProfile() async {
    if (_formKey.currentState!.validate()) {
      final Map<String, dynamic> profileData = {
        "cus_name": _nameController.text,
        "cus_add": _addressController.text,
        "cus_city": _cityController.text,
        "cus_state": _stateController.text,
        "cus_postcode": _postcodeController.text,
        "cus_country": _countryController.text,
        "cus_phone": _phoneController.text,
        "cus_fax": _phoneController.text,
        "ship_name":
            _receiverNameController.text, // Use _receiverNameController here
        "ship_add": _shippingAddressController.text,
        "ship_city": _cityController.text,
        "ship_state": _stateController.text,
        "ship_postcode": _postcodeController.text,
        "ship_country": _countryController.text,
        "ship_phone": _receiverContact.text, // Use _receiverContact here
      };

      final NetworkResponse response = await NetworkCaller.postRequest(
        Urls.CreateProfile,
        profileData,
      );

      if (response.isSuccess) {
        Get.snackbar("Congratulations",
            "Successfully ${'${successMessage}d'} Your Profile");
        Get.to(MainBottomNavScreen());
      } else {
        Get.snackbar("Error", "Please retry");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Center(
                    child: SvgPicture.asset(
                      ImageAssets.craftyBayLogoSVG,
                      width: 100,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    '$successMessage Profile',
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          fontSize: 24,
                        ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text('Get started with us by sharing your details',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(color: Colors.grey)),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextFormField(_nameController, "Name"),
                  CustomTextFormField(_addressController, "Address"),
                  CustomTextFormField(_cityController, "City"),
                  CustomTextFormField(_stateController, "State"),
                  CustomTextFormField(_postcodeController, "Postcode"),
                  CustomTextFormField(_countryController, "Country"),
                  CustomTextFormField(_phoneController, "Phone"),
                  CustomTextFormField(_receiverNameController, "Receiver Name"),
                  CustomTextFormField(
                      _receiverContact, "Receiver Phone Number"),
                  TextFormField(
                    controller: _shippingAddressController,
                    maxLines: 6,
                    decoration: const InputDecoration(
                      labelText: 'Shipping Address',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Shipping Address is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: completeProfile,
                      child: Text(successMessage),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column CustomTextFormField(TextEditingController conT, String label) {
    return Column(
      children: [
        TextFormField(
          controller: conT,
          decoration: InputDecoration(labelText: label),
          validator: (value) {
            if (value!.isEmpty) {
              return '$label is required';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }
}
