import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:marafq/api_services/api_service.dart';
import 'package:marafq/style/appStyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddReport extends StatelessWidget {
  const AddReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تقديم بلاغ', style: AppStyles.textStyle),
      ),
      body: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget();

  @override
  // ignore: library_private_types_in_public_api
  _MyStatefulWidgetState createState() =>
      // ignore: no_logic_in_create_state
      _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController classNameController = TextEditingController();
  TextEditingController roomIDController = TextEditingController();

  TextEditingController dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1, 1),
        lastDate: DateTime(2100, 1, 1));
    if (picked != null && picked != selectedDate) {
      setState(() {
        // print("date" + dateFormat.format(picked));
        selectedDate = picked;
        dateController.value =
            TextEditingValue(text: dateFormat.format(picked));
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  _MyStatefulWidgetState();
  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop(true);
        // Navigator.pushNamed(context, '/roomList');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text('Success'),
      content: Text('Form submitted successfully.'),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _addReport() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final userData = json.decode(pref.getString('userData').toString());
    var object = {
      'user_id': userData['id'],
      'date': dateController.text,
      'status': "booked"
    };

    var isAdded = (await ApiService().addReport(object));
    if (isAdded) {
      showAlertDialog(context);
      // Navigator.pop(context);
      // ignore: use_build_context_synchronously
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => const RoomList()));
    }
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    String? selectedValue;
    var items = [
      'Apple',
      'Banana',
      'Grapes',
      'Orange',
      'watermelon',
      'Pineapple'
    ];
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                ),
                Container(
                    height: 40,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(
                          color: Colors.grey,
                          style: BorderStyle.solid,
                          width: 0.20),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        hint: Text(
                          'Select Item',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: items
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            log(newValue!);
                            selectedValue = newValue;
                          });
                        },
                        buttonStyleData: const ButtonStyleData(
                          height: 40,
                          width: 120,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                        // buttonHeight: 40,
                        // buttonWidth: 140,
                        // itemHeight: 40,
                      ),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    style: AppStyles.textStyleInput,
                    controller: nameController,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'is empty';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'وصف البلاغ',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    maxLines: null,
                    minLines: 3,
                    keyboardType: TextInputType.multiline,
                    style: AppStyles.textStyleInput,
                    controller: nameController,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return ' is empty';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'مكان البلاغ',
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: ElevatedButton(
                      child: const Text(
                        'تقديم',
                        style: AppStyles.textStyle,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _addReport();
                        }
                      },
                    )),
              ],
            )));
  }
}
