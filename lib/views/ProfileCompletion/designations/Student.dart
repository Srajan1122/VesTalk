import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/views/LandingPage/LandingPage.dart';

class Student extends StatefulWidget {
  @override
  _StudentState createState() => _StudentState();
}

class _StudentState extends State<Student> {
  String id, branch, batch, year;
  DatabaseMethods databaseMethods = new DatabaseMethods();
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

  getUserId() async {
    await SharedPreferences.getInstance().then((value) => {
          this.setState(() {
            id = value.getString('id');
          })
        });
  }

  bool checkValidation() {
    if (branch == null || batch == null || year == null) {
      _showDialog();
      Fluttertoast.showToast(msg: "Please enter all the fields");
      return false;
    }

    return true;
  }

  void _validNumber() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "Warning !",
            textAlign: TextAlign.center,
          ),
          content: new Text("Please enter a valid number"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "Close",
                style: TextStyle(color: Color(0xFFFC2542)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "Warning !",
            textAlign: TextAlign.center,
          ),
          content: new Text("Please enter all the fields"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "Close",
                style: TextStyle(color: Color(0xFFFC2542)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget customDropdown(hint, variable, list) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: DropdownButton<String>(
        hint: Text(hint.padRight(25)),
        icon: Icon(Icons.arrow_downward),
        value: variable,
        iconSize: 24,
        elevation: 16,
        underline: Container(
          height: 2,
          color: Colors.lightBlue,
        ),
        onChanged: (String newValue) {
          setState(() {
            if (hint == "Select Branch")
              branch = newValue;
            else if (hint == "Select Year")
              year = newValue;
            else if (hint == "Select Division") {
              batch = newValue;
            }

            if (branch == 'INFT') {
              print('ya i am inft');
              listOfYear = ['1st Year', '2nd Year', '3rd Year', '4th Year'];
              if (year == '1st Year') {
                listOfBatch = ['D5A', 'D5B'];
              } else if (year == '2nd Year') {
                listOfBatch = ['D10A', 'D10B'];
              } else if (year == '3rd Year') {
                batch = 'D15';
                listOfBatch = ['D15'];
              } else if (year == '4th Year') {
                batch = 'D20';
                listOfBatch = ['D20'];
              } else
                listOfBatch = ['D5A', 'D5B', 'D10A', 'D10B', 'D15', 'D20'];
            } else if (branch == 'CMPN') {
              print('ya i am cs');
              listOfYear = ['1st Year', '2nd Year', '3rd Year', '4th Year'];
              if (year == '1st Year')
                listOfBatch = ['D2A', 'D2B', 'D2C'];
              else if (year == '2nd Year')
                listOfBatch = ['D7A', 'D7B', 'D7C'];
              else if (year == '3rd Year') {
                listOfBatch = ['D12A', 'D12B', 'D12C'];
              } else if (year == '4th Year') {
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
            } else if (branch == 'ETRX') {
              print('ya i am etrx');
              listOfYear = ['1st Year', '2nd Year', '3rd Year', '4th Year'];
              if (year == '1st Year') {
                listOfBatch = ['D1A', 'D1B'];
              } else if (year == '2nd Year') {
                listOfBatch = ['D6A', 'D6B'];
              } else if (year == '3rd Year') {
                listOfBatch = ['D11A', 'D11B'];
              } else if (year == '4th Year') {
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
            } else if (branch == 'INST') {
              print('ya i am inst');
              listOfYear = ['1st Year', '2nd Year', '3rd Year', '4th Year'];
              if (year == '1st Year') {
                listOfBatch = ['D3'];
                batch = 'D3';
              } else if (year == '2nd Year') {
                listOfBatch = ['D8'];
                batch = 'D8';
              } else if (year == '3rd Year') {
                listOfBatch = ['D13'];
                batch = 'D13';
              } else if (year == '4th Year') {
                listOfBatch = ['D18'];
                batch = 'D18';
              } else
                listOfBatch = [
                  'D3',
                  'D8',
                  'D13',
                  'D18',
                ];
            } else if (branch == 'EXTC') {
              print('ya i am inst');
              listOfYear = ['1st Year', '2nd Year', '3rd Year', '4th Year'];
              if (year == '1st Year') {
                listOfBatch = ['D4A', 'D4B'];
              } else if (year == '2nd Year') {
                listOfBatch = ['D9A', 'D9B'];
              } else if (year == '3rd Year') {
                listOfBatch = ['D14A', 'D14B'];
              } else if (year == '4th Year') {
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
            } else if (branch == 'MCA') {
              listOfYear = ['1st Year', '2nd Year'];
              if (year == '1st Year') {
                listOfBatch = ['MCA 1A', 'MCA 1B'];
              } else if (year == '2nd Year') {
                listOfBatch = ['MCA 2A', 'MCA 2B'];
              }
            }
            if (!listOfBatch.contains(batch)) batch = null;
            if (!listOfYear.contains(year)) year = null;
          });
        },
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  onSubmit(context) async {
    if (!checkValidation()) {
      print('not good');
    } else {
      print('good to go');
      await getUserId();
      databaseMethods.uploadStudentInfo(id, branch, batch, year);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LandingPage()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/ProfileComp/OnBoarding.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: Container(
              width: 450,
              height: 800,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 30, 40, 40),
                    child: Center(
                      child: Text(
                        'Student Details :',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                  customDropdown("Select Branch", branch, listOfBranch),
                  customDropdown("Select Year", year, listOfYear),
                  customDropdown("Select Division", batch, listOfBatch),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 5, 40, 40),
                    child: Center(
                      child: Text(
                        'Note: After you pass out, you can change your designation to Alumni',
                        style:
                            TextStyle(fontSize: 10, color: Color(0xFFFC2542)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 31),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: FloatingActionButton(
                  heroTag: "btn1",
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: FaIcon(FontAwesomeIcons.arrowLeft),
                  backgroundColor: Colors.lightBlue,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                heroTag: "btn2",
                onPressed: () {
                  onSubmit(context);
                },
                child: FaIcon(FontAwesomeIcons.arrowRight),
                backgroundColor: Colors.lightBlue,
              ),
            ),
          ],
        ));
  }
}
