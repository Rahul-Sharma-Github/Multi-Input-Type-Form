import 'package:flutter/material.dart';
import 'package:test1/choicechip_controller.dart';
import 'package:test1/controller.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:email_validator/email_validator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

// Home Page
class HomePage extends StatelessWidget {
  HomePage({super.key});

  // profile Controller
  final ProfileController profileController = Get.put(ProfileController());

  // choiceChipController
  final ChoiceChipController choiceChipController =
      Get.put(ChoiceChipController());

  // Global key for Form
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                    child: Center(
                        child: Text(
                  'Profile',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ))),
              ],
            ),
            SizedBox(height: 30),

            // Name Field
            TextFormField(
              controller: profileController.nameTextEditingController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your Name';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
                prefixIcon: Icon(Icons.person),
                label: Text('Name'),
              ),
            ),
            SizedBox(height: 20),

            // Mobile Number Field
            IntlPhoneField(
              focusNode: FocusNode(),
              // controller: profileController.mobileNumberTextEditingController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              languageCode: "en",
              initialCountryCode: 'IN',
              onChanged: (phone) {
                // debugPrint(phone.completeNumber);
                profileController.mobileNumberTextEditingController.text =
                    phone.completeNumber;
                debugPrint(
                    profileController.mobileNumberTextEditingController.text);
              },
              onCountryChanged: (country) {
                debugPrint('Country changed to: ${country.name}');
              },
            ),

            SizedBox(height: 20),

            // Date Selection
            TextFormField(
              controller: profileController.dateOfBirthTextEditingController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Select New Date';
                } else {
                  return null;
                }
              },
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  initialDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  if (pickedDate.difference(DateTime.now()).inDays == 0) {
                    debugPrint('Date is Same.');
                    profileController.dateOfBirthTextEditingController.text =
                        '';
                  } else {
                    debugPrint('Date is Not Same.');
                    // Assigning picked date in specific format
                    profileController.dateOfBirthTextEditingController.text =
                        DateFormat.yMd().format(pickedDate);
                  }
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
                label: Text('Select Birth Date'),
                prefixIcon: Icon(Icons.calendar_month),
              ),
              // to hide keyboard
              keyboardType: TextInputType.none,
              showCursor: false,
              // to prevent keyboard input
              readOnly: true,
            ),

            SizedBox(height: 20),

            // Email Field
            TextFormField(
              controller: profileController.emailTextEditingController,
              validator: (value) {
                if (!EmailValidator.validate(value!)) {
                  return 'please enter valid Email';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
                label: Text('Email'),
                prefixIcon: Icon(Icons.email),
              ),
            ),

            SizedBox(height: 20),

            // Gender Selection
            Obx(
              () => DropdownMenu(
                expandedInsets: EdgeInsets.zero,
                leadingIcon: Icon(Icons.male_outlined),
                label: Text('Select Gender'),
                dropdownMenuEntries: profileController.genderItems
                    .map(
                      (e) => DropdownMenuEntry(value: e, label: e),
                    )
                    .toList(),
                onSelected: (value) {
                  if (value!.isNotEmpty) {
                    profileController.gender.value = value;
                  }
                },
              ),
            ),

            SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                    child: Text(
                  'Select Hobbies',
                  style: TextStyle(fontSize: 16.0),
                ))
              ],
            ),
            SizedBox(height: 10),
            // Hobbies selection
            Obx(
              () => Wrap(
                spacing: 10,
                children: choiceChipController.choiceList
                    .map(
                      (e) => ChoiceChip(
                        label: Text(e),
                        selectedColor: Colors.green,
                        selected:
                            choiceChipController.selectedChoiceList.contains(e),
                        onSelected: (value) {
                          if (value) {
                            choiceChipController.selectedChoiceList.add(e);
                            debugPrint('$e = added into selectedChoiceList.');
                          } else {
                            choiceChipController.selectedChoiceList
                                .removeWhere((element) => element == e);
                            debugPrint('$e = removed from selectedChoiceList.');
                          }
                        },
                      ),
                    )
                    .toList(),
              ),
            ),

            SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                    child: Text(
                  'Enter Description',
                  style: TextStyle(fontSize: 16.0),
                ))
              ],
            ),
            SizedBox(height: 10),
            // Multiline text input
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
                prefixIcon: Icon(Icons.description),
              ),
              maxLines: 4,
              keyboardType: TextInputType.multiline,
            ),

            SizedBox(height: 60),

            // Continue Button
            Obx(
              () => ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    if (profileController.isDataValid()) {
                      profileController.postData();
                    } else {
                      debugPrint(
                          'Warning = First enter required values in fields.');
                    }
                  } else {
                    debugPrint(
                        'Warning = First enter required values in fields.');
                  }
                },
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(
                    EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                  ),
                  backgroundColor: WidgetStatePropertyAll(Color(0xff06844b)),
                ),
                child: profileController.isLoading.value
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Continue',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
