import 'package:flutter/material.dart';
import 'package:health_tracker/components/my_snackbar.dart';
import 'package:health_tracker/controller/profile_controller.dart';
import 'package:health_tracker/controller/user_controller.dart';
import 'package:health_tracker/models/user_information.dart';
import 'package:health_tracker/pages/login_page.dart';
import 'package:health_tracker/utils/icon.dart';
import 'package:health_tracker/utils/style.dart';
import 'package:flutter/services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController _profileController = ProfileController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  bool _emailReadOnly = false;
  bool _isDataHasChanged = false;

  final List<String> _genderList = ['Male', 'Female', 'Other'];
  String _genderValue = 'Other';

  @override
  void initState() {
    super.initState();
    _emailController.text = UserController.user?.email ?? '';
    _emailReadOnly = UserController.user?.email != null;

    _profileController
        .getUserInformationByUserUid(UserController.user?.uid ?? '')
        .then((value) {
      setState(() {
        _genderValue = _genderList.firstWhere(
          (element) {
            return element.toLowerCase() == value.gender.toLowerCase();
          },
        );
        _ageController.text = '${value.age}';
        _heightController.text = '${value.height}';
        _weightController.text = '${value.weight}';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double topScreenMargin = MediaQuery.of(context).viewPadding.top;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(
          left: screenWidth * .025,
          right: screenWidth * .025,
          bottom: screenWidth * .025),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: topScreenMargin + 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Ink(
                  decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
                SizedBox(width: screenWidth * .025),
              ],
            ),
          ),
          CircleAvatar(
            radius: 65,
            foregroundImage: NetworkImage(UserController.user?.photoURL ?? ''),
          ),
          const SizedBox(height: 20),
          Text(
            UserController.user?.displayName?.split(' ')[0] ?? 'Guest',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: screenHeight * 0.03),
          const Row(
            children: [
              Text(
                'Email',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              height: 50,
              child: TextField(
                readOnly: _emailReadOnly,
                controller: _emailController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  border: OutlineInputBorder(),
                  hintText: 'your@email.com',
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          const Row(
            children: [
              Text(
                'User Information',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'It is necessary information for calculting BMR.',
                style: MyTextStyle.subtitle(),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.03),
          Row(
            children: [
              SizedBox(
                width: screenWidth * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gender',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            buildIcon('gender'),
                            SizedBox(
                              height: 50,
                              child: DropdownButton<String>(
                                  value: _genderValue,
                                  icon: const Icon(Icons.edit),
                                  items: _genderList
                                      .map((String value) =>
                                          DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          ))
                                      .toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _genderValue = newValue ?? '';
                                      _isDataHasChanged = true;
                                    });
                                  }),
                              // ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: screenWidth * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Age',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 50,
                      child: TextField(
                        onChanged: (newText) {
                          setState(() {
                            if (newText == '') {
                              _ageController.text = '';
                            } else if (int.parse(newText) < 0) {
                              _ageController.text = '0';
                            } else {
                              _isDataHasChanged = true;
                            }
                          });
                        },
                        controller: _ageController,
                        keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Allow only digits
                          ],
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          prefixIcon: buildIcon('age'),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.03),
          Row(
            children: [
              SizedBox(
                width: screenWidth * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Height (cm)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 50,
                      child: TextField(
                        onChanged: (newText) {
                          setState(() {
                            if (newText == '') {
                              _ageController.text = '';
                            } else if (int.parse(newText) < 0) {
                              _ageController.text = '0';
                            } else {
                              _isDataHasChanged = true;
                            }
                          });
                        },
                        controller: _heightController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Allow only digits
                        ],                        
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          prefixIcon: buildIcon('height'),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: screenWidth * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Weight (kg)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 50,
                      child: TextField(
                        onChanged: (newText) {
                          setState(() {
                            if (newText == '') {
                              _ageController.text = '';
                            } else if (int.parse(newText) < 0) {
                              _ageController.text = '0';
                            } else {
                              _isDataHasChanged = true;
                            }
                          });
                        },
                        controller: _weightController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Allow only digits
                        ],                         
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          prefixIcon: buildIcon('weight'),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [widgetWhenDataHasChange(_isDataHasChanged)],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0.0, 3.0),
                        blurRadius: 1.0,
                        spreadRadius: -2.0,
                        color: Colors.black.withOpacity(.025)),
                    BoxShadow(
                        offset: const Offset(0.0, 2.0),
                        blurRadius: 2.0,
                        color: Colors.black.withOpacity(.025)),
                    BoxShadow(
                        offset: const Offset(0.0, 1.0),
                        blurRadius: 5.0,
                        color: Colors.black.withOpacity(.025)),
                  ],
                ),
                child: ElevatedButton(
                    onPressed: () => {
                          UserController.signOut(),
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LoginPage()))
                        },
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                    child: Row(
                      children: [
                        buildIcon('logout', color: MyColors.wrong),
                        const SizedBox(width: 10),
                        const Text(
                          "Logout",
                          style: TextStyle(
                              color: MyColors.wrong,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
              )
            ],
          )
        ],
      ),
    ));
  }

  Widget widgetWhenDataHasChange(bool isDataHasChanged) {
    if (isDataHasChanged) {
      return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: const Offset(0.0, 3.0),
                blurRadius: 1.0,
                spreadRadius: -2.0,
                color: Colors.black.withOpacity(.025)),
            BoxShadow(
                offset: const Offset(0.0, 2.0),
                blurRadius: 2.0,
                color: Colors.black.withOpacity(.025)),
            BoxShadow(
                offset: const Offset(0.0, 1.0),
                blurRadius: 5.0,
                color: Colors.black.withOpacity(.025)),
          ],
        ),
        child: ElevatedButton(
            onPressed: () => {
                  _profileController.updateUserInformationByUserId(
                      UserInformation(
                          userId: UserController.user?.uid ?? '',
                          gender: _genderValue.toLowerCase(),
                          age: _ageController.text == ''
                              ? 0
                              : int.parse(_ageController.text),
                          height: _heightController.text == ''
                              ? 0
                              : int.parse(_heightController.text),
                          weight: _weightController.text == ''
                              ? 0
                              : int.parse(_weightController.text))),
                  setState(() {
                    _isDataHasChanged = false;
                  }),
                  ScaffoldMessenger.of(context).showSnackBar(mySnackBar(
                      SnackBarType.success, "Save all change successfully!",
                      textStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)))
                },
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(color: Colors.black)),
                ),
                backgroundColor:
                    MaterialStateProperty.all<Color>(MyColors.correct)),
            child: const Row(
              children: [
                Icon(Icons.edit_attributes_outlined, color: Colors.black),
                SizedBox(width: 10),
                Text(
                  "Save change",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            )),
      );
    } else {
      return Container();
    }
  }
}
