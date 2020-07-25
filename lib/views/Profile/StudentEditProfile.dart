import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/services/constant.dart';

import 'DesignationProfilePage/Widgets/EditProfileTopImage.dart';

class StudentEditProfile extends StatefulWidget {
  const StudentEditProfile({
    Key key,
    @required this.photoUrl,
    @required this.name,
    @required this.email,
    @required this.designation,
    @required this.branch,
    @required this.year,
    @required this.batch,
  }) : super(key: key);

  final String photoUrl;
  final String name;
  final String email;
  final String designation;
  final String branch;
  final String batch;
  final String year;

  @override
  _StudentEditProfileState createState() => _StudentEditProfileState();
}

class _StudentEditProfileState extends State<StudentEditProfile> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController phoneController = new TextEditingController();
  String newBranch, newYear, newBatch, newPhone;
  List<String> listOfBranch = ['ETRX', 'CMPN', 'INST', 'EXTC', 'INFT', 'MCA'];
  List<String> listOfYear = ['1st Year', '2nd Year', '3rd Year', '4th Year'];
  List<String> listOfBatch = [
    'D1A',
    'D1B',
    'D2A',
    'D2B',
    'D2C',
    'D3',
    'D4A',
    'D4B',
    'D5A',
    'D5B',
    'D6A',
    'D6B',
    'D7A',
    'D7B',
    'D7C',
    'D8',
    'D9A',
    'D9B',
    'D10',
    'D11A',
    'D11B',
    'D12A',
    'D12B',
    'D12C',
    'D13',
    'D14A',
    'D14B',
    'D15',
    'D16A',
    'D16B',
    'D17A',
    'D17B',
    'D17C',
    'D18',
    'D19A',
    'D19B',
    'D20',
    'MCA 1A',
    'MCA 1B',
    'MCA 2A',
    'MCA 2B'
  ];

  Widget customDropDown(title, hint, variable, list) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 40.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title.padRight(15),
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w300),
            ),
            SizedBox(
              width: 20.0,
            ),
            DropdownButton<String>(
              hint: Text(hint.padRight(25)),
              icon: Icon(Icons.arrow_downward),
              value: variable,
              iconSize: 24,
              elevation: 16,
              underline: Container(
                height: 1,
                color: Colors.lightBlue,
              ),
              onChanged: (String newValue) {
                setState(() {
                  if (title == 'Branch')
                    newBranch = newValue;
                  else if (title == 'Year')
                    newYear = newValue;
                  else if (title == 'Batch') newBatch = newValue;

                  if (newBranch == 'INFT') {
                    print('ya i am inft');
                    listOfYear = [
                      '1st Year',
                      '2nd Year',
                      '3rd Year',
                      '4th Year'
                    ];
                    if (newYear == '1st Year') {
                      listOfBatch = ['D5A', 'D5B'];
                    } else if (newYear == '2nd Year') {
                      listOfBatch = ['D10A', 'D10B'];
                    } else if (newYear == '3rd Year') {
                      newBatch = 'D15';
                      listOfBatch = ['D15'];
                    } else if (newYear == '4th Year') {
                      newBatch = 'D20';
                      listOfBatch = ['D20'];
                    } else
                      listOfBatch = [
                        'D5A',
                        'D5B',
                        'D10A',
                        'D10B',
                        'D15',
                        'D20'
                      ];
                  } else if (newBranch == 'CMPN') {
                    print('ya i am cs');
                    listOfYear = [
                      '1st Year',
                      '2nd Year',
                      '3rd Year',
                      '4th Year'
                    ];
                    if (newYear == '1st Year')
                      listOfBatch = ['D2A', 'D2B', 'D2C'];
                    else if (newYear == '2nd Year')
                      listOfBatch = ['D7A', 'D7B', 'D7C'];
                    else if (newYear == '3rd Year') {
                      listOfBatch = ['D12A', 'D12B', 'D12C'];
                    } else if (newYear == '4th Year') {
                      listOfBatch = ['D17A', 'D17B', 'D17C'];
                    } else
                      listOfBatch = [
                        'D2A',
                        'D2B',
                        'D2C',
                        'D7A',
                        'D7B',
                        'D7C',
                        'D12A',
                        'D12B',
                        'D12C',
                        'D17A',
                        'D17B',
                        'D17C'
                      ];
                  } else if (newBranch == 'ETRX') {
                    print('ya i am etrx');
                    listOfYear = [
                      '1st Year',
                      '2nd Year',
                      '3rd Year',
                      '4th Year'
                    ];
                    if (newYear == '1st Year') {
                      listOfBatch = ['D1A', 'D1B'];
                    } else if (newYear == '2nd Year') {
                      listOfBatch = ['D6A', 'D6B'];
                    } else if (newYear == '3rd Year') {
                      listOfBatch = ['D11A', 'D11B'];
                    } else if (newYear == '4th Year') {
                      listOfBatch = ['D16A', 'D16B'];
                    } else
                      listOfBatch = [
                        'D1A',
                        'D1B',
                        'D6A',
                        'D6B',
                        'D11A',
                        'D11B',
                        'D16A',
                        'D16B'
                      ];
                  } else if (newBranch == 'INST') {
                    print('ya i am inst');
                    listOfYear = [
                      '1st Year',
                      '2nd Year',
                      '3rd Year',
                      '4th Year'
                    ];
                    if (newYear == '1st Year') {
                      listOfBatch = ['D3'];
                      newBatch = 'D3';
                    } else if (newYear == '2nd Year') {
                      listOfBatch = ['D8'];
                      newBatch = 'D8';
                    } else if (newYear == '3rd Year') {
                      listOfBatch = ['D13'];
                      newBatch = 'D13';
                    } else if (newYear == '4th Year') {
                      listOfBatch = ['D18'];
                      newBatch = 'D18';
                    } else
                      listOfBatch = [
                        'D3',
                        'D8',
                        'D13',
                        'D18',
                      ];
                  } else if (newBranch == 'EXTC') {
                    print('ya i am inst');
                    listOfYear = [
                      '1st Year',
                      '2nd Year',
                      '3rd Year',
                      '4th Year'
                    ];
                    if (newYear == '1st Year') {
                      listOfBatch = ['D4A', 'D4B'];
                    } else if (newYear == '2nd Year') {
                      listOfBatch = ['D9A', 'D9B'];
                    } else if (newYear == '3rd Year') {
                      listOfBatch = ['D14A', 'D14B'];
                    } else if (newYear == '4th Year') {
                      listOfBatch = ['D19A', 'D19B'];
                    } else
                      listOfBatch = [
                        'D4A',
                        'D4B',
                        'D9A',
                        'D9B',
                        'D14A',
                        'D14B',
                        'D19A',
                        'D19B'
                      ];
                  } else if (newBranch == 'MCA') {
                    listOfYear = ['1st Year', '2nd Year'];
                    if (newYear == '1st Year') {
                      listOfBatch = ['MCA 1A', 'MCA 1B'];
                    } else if (newYear == '2nd Year') {
                      listOfBatch = ['MCA 2A', 'MCA 2B'];
                    }
                  }
                  if (!listOfBatch.contains(newBatch)) newBatch = null;
                  if (!listOfYear.contains(newYear)) newYear = null;
                });
              },
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ],
    );
  }

  Widget customInputField(title) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 40.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title.padRight(15),
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w300),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: TextField(
                maxLength: 10,
                maxLengthEnforced: true,
                controller: phoneController,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ],
    );
  }

  check() {
    if (phoneController.text.length != 10) return false;
    return true;
  }

  onSubmit() async {
    if (!check()) {
      Fluttertoast.showToast(msg: "Please enter all the fields correctly");
    } else {
      await databaseMethods.updateStudentInfo(
          Constants.uid, phoneController.text, newBranch, newBatch, newYear);
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    newBranch = widget.branch;
    newYear = widget.year;
    newBatch = widget.batch;
    phoneController..text = newPhone;
  }

  @override
  Widget build(BuildContext context) {
    return FocusWatcher(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.clear, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Edit Profile',
            style: TextStyle(fontFamily: 'Montserrat', color: Colors.black),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.black,
              ),
              onPressed: onSubmit,
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  EditProfileTopImage(widget: widget),
                  customDropDown(
                      'Branch', 'Select Branch', newBranch, listOfBranch),
                  customDropDown('Year', 'Select Year', newYear, listOfYear),
                  customDropDown(
                      'Batch', 'Select Batch', newBatch, listOfBatch),
                  customInputField('Phone Number'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
