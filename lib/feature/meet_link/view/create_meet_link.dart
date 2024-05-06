import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:student_verification_system/common/common.dart';
import 'package:student_verification_system/constants/constants.dart';
import 'package:student_verification_system/core/core.dart';
import 'package:student_verification_system/feature/admin_home/view/admin_home_controller.dart';
import 'package:student_verification_system/feature/auth/view/class_selection_button.dart';
import 'package:student_verification_system/feature/meet_link/controller/meet_link_controller.dart';
import 'package:student_verification_system/theme/theme.dart';

class CreateMeetLink extends ConsumerStatefulWidget {
  const CreateMeetLink({super.key});
  static route() {
    return MaterialPageRoute(
      builder: (context) => const CreateMeetLink(),
    );
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateMeetLinkState();
}

class _CreateMeetLinkState extends ConsumerState<CreateMeetLink> {
  TextEditingController meetLinkEditingController = TextEditingController();
  String? _standard;

  void shareLink({required BuildContext context}) {
    final text = meetLinkEditingController.text.trim();

    if (!text.contains('https://meet.google.com/') ||
        _standard == null ||
        chosenSubject == null ||
        selectedTime == null) {
      showSnackBar(context, "Please ensure that everything is filled correctly"
          // "Please enter the link in correct form like https://meet.google.com/kbp-rsyg-mjc",
          );
    } else {
      print(chosenSubject);
      ref.watch(meetLinkControllerProvider.notifier).shareMeetLink(
            meetLink: text,
            time: selectedTime!,
            subject: chosenSubject!,
            context: context,
            standard: _standard!,
          );
    }
  }

  void _onDropDownValueChangedSubject(String? value) {
    setState(() {
      chosenSubject = value;
    });
  }

  void _onDropDownValueChangedTime(String? value) {
    setState(() {
      selectedTime = value;
    });
  }

  final List<String> subjects = [
    'English',
    'Physics',
    'Maths',
    'Business studies',
    'Economics',
    'IP',
    'PE',
    'Hindi',
  ];
  final List<String> time = ["9 AM", "10 AM", "11 AM", "12 PM"];
  String? selectedTime;
  String? chosenSubject;
  List<String> meetClasses = ['12 A', '12 B'];
  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(meetLinkControllerProvider);
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(
          onPressed: () => Navigator.pop(context, AdminHomeView.route()),
          // onPressed: () {},
          style: ButtonStyle(iconSize: MaterialStateProperty.all(30)),
        ),
        title: SvgPicture.asset(
          AssetsConstants.googleLogo,
          height: 30,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SmallRoundedButton(
              onTap: () {
                shareLink(context: context);
              },
              label: "Send Link",
              backgroundColor: Pallete.blueColor,
              textColor: Pallete.whiteColor,
            ),
          )
        ],
      ),

      //body part where post will be written
      body: isLoading
          ? const Loader()
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 2.5, 0, 0),
                            child: TextFormField(
                              style: const TextStyle(fontSize: 20),
                              controller: meetLinkEditingController,
                              autofocus: true,
                              maxLength: 100,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.fromLTRB(0, 0, 10, 0),
                                hintText: "Enter the Google Meet Link",
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                ),
                              ),
                              maxLines: null,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(
                              meetClasses.length,
                              (index) => Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: ClassSelectionBUtton(
                                    onTap: () {
                                      setState(() {
                                        _standard = meetClasses[index];
                                      });
                                    },
                                    label: meetClasses[index],
                                    backgroundColor: _standard !=
                                            meetClasses[index]
                                        ? const Color.fromARGB(255, 26, 26, 26)
                                        : const Color.fromARGB(255, 83, 83, 83),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          DropDownButton(
                            label: 'Select subject',
                            items: subjects,
                            onValueChanged: _onDropDownValueChangedSubject,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DropDownButton(
                            label: "Select time",
                            items: time,
                            onValueChanged: _onDropDownValueChangedTime,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class DropDownButton extends StatefulWidget {
  final List<String> items; // List of items for the dropdown
  final String label;
  final void Function(String?)
      onValueChanged; // Callback function to pass the selected value

  const DropDownButton(
      {super.key,
      required this.items,
      required this.label,
      required this.onValueChanged});

  @override
  // ignore: library_private_types_in_public_api
  _DropDownButtonState createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  String? selectedValue; // Variable to hold the selected item

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Row(
          children: [
            const Icon(
              Icons.list,
              size: 16,
              color: Pallete.whiteColor,
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Pallete.whiteColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: widget.items
            .map(
              (String item) => DropdownMenuItem<String>(
                value: item,
                alignment: Alignment.center,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
            .toList(),
        value: selectedValue, // Pass the selected value
        onChanged: (String? value) {
          setState(() {
            selectedValue = value; // Update the selected value
          });
          widget.onValueChanged(
              value); // Call the callback function with the selected value
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
            color: Pallete.searchBarColor,
          ),
          elevation: 8,
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_forward_ios_outlined,
          ),
          iconSize: 14,
          iconEnabledColor: Pallete.blueColor,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 400,
          width: MediaQuery.of(context).size.width - 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Pallete.searchBarColor,
          ),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all<double>(6),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}
