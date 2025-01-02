import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:test1/model.dart';

class ProfileController extends GetxController {
  // TextEditing Controllers + variable to control entered/selected values for TextFields & DropDown Menus
  final TextEditingController nameTextEditingController =
      TextEditingController();
  final TextEditingController mobileNumberTextEditingController =
      TextEditingController();
  final TextEditingController dateOfBirthTextEditingController =
      TextEditingController();
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final gender = ''.obs;

  // variables to store data from profile form
  var name = ''.obs;
  var mobileNumber = ''.obs;
  var dateOfBirth = ''.obs;
  var email = ''.obs;
  var selectedGender = ''.obs;
  final List<String> genderItems = ['Male', 'Female'].obs;

  // variable to indicate success / waiting
  final RxBool isLoading = false.obs;

  // method to store and Check data
  bool isDataValid() {
    debugPrint('Info = isDataValid() called.');

    // storing field values into variables using their
    name.value = nameTextEditingController.text.trim();
    mobileNumber.value = mobileNumberTextEditingController.text.trim();
    dateOfBirth.value = dateOfBirthTextEditingController.text.trim();
    email.value = emailTextEditingController.text.trim();
    selectedGender.value = gender.value;

    // checking stored values
    if (name.value.isEmpty ||
        mobileNumber.value.isEmpty ||
        mobileNumber.value.length < 6 ||
        dateOfBirth.value.isEmpty ||
        email.value.isEmpty ||
        selectedGender.value.isEmpty) {
      // Printing Data to console
      debugPrint('Info = Field Values are Not inserted Properly.');
      debugPrint('name = ${name.value}');
      debugPrint('mobileNumber = ${mobileNumber.value}');
      debugPrint('dateOfBirth = ${dateOfBirth.value}');
      debugPrint('email = ${email.value}');
      debugPrint('selectedGender = ${selectedGender.value}');

      return false;
    } else {
      // Printing Data to console
      debugPrint('Info = Field Values are inserted Properly.');
      debugPrint('name = ${name.value}');
      debugPrint('mobileNumber = ${mobileNumber.value}');
      debugPrint('dateOfBirth = ${dateOfBirth.value}');
      debugPrint('email = ${email.value}');
      debugPrint('selectedGender = ${selectedGender.value}');

      // updating isLoading variable value to true
      isLoading.value = true;
      return true;
    }
  }

  // method to post the data after checking
  Future<void> postData() async {
    debugPrint('Info = postData() called.');
    try {
      final response = await http.post(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
        headers: {'Content-Type': 'application/json'},
        body: welcomeToJson(
          Welcome(
            name: name.value,
            number: mobileNumber.value,
            date: dateOfBirth.value,
            email: email.value,
            gender: selectedGender.value,
          ),
        ),
      );
      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Form submitted successfully',
            snackPosition: SnackPosition.BOTTOM);
        debugPrint('Response data  = ${response.body}');
      } else {
        Get.snackbar('Error', 'Failed to submit the form',
            snackPosition: SnackPosition.BOTTOM);
        debugPrint('Response data  = ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred = $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      Get.snackbar('Info = ', 'Finally Block Called !');
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameTextEditingController.dispose();
    mobileNumberTextEditingController.dispose();
    dateOfBirthTextEditingController.dispose();
    emailTextEditingController.dispose();
    super.onClose();
  }
}
