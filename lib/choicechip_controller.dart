import 'package:get/get.dart';

class ChoiceChipController extends GetxController {
  // List of choice chips
  List<String> choiceList =
      ['Cricket', 'Football', 'Badminton', 'Volleyball'].obs;

  // List variable to store selected choice
  var selectedChoiceList = [''].obs;
}
