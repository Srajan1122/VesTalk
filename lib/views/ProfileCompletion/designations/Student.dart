import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/views/LandingPage/LandingPage.dart';

class Student extends StatefulWidget {
  @override
  _StudentState createState() => _StudentState();
}

class _StudentState extends State<Student> {
  String id, phoneNumber, branch, batch, year;
  DatabaseMethods databaseMethods = new DatabaseMethods();

  getUserId() async {
    await SharedPreferences.getInstance().then((value) => {
      this.setState(() {
        id = value.getString('id');
      })
    });
  }

  bool checkValidation() {
    if (phoneNumber.length != 10) {
      // TODO : show alert
      return false;
    }
    if (branch == null || batch == null || year == null) {
      return false;
    }

    return true;
  }

  onSubmit(context) async {
    if(!checkValidation()){
      print('not good');
    }
    else{
      print('good to go');
      await getUserId();
      databaseMethods.uploadStudentInfo(id, phoneNumber, branch, batch, year);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LandingPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/ProfileComp/ProfileCompletion.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Container(
            width: 300,
            height: 500,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 5.0,
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: Center(
                    child: Text('Student Details :', style: TextStyle(fontSize: 20),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                  child: Container(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Your Phone number',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          phoneNumber = value;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: DropdownButton<String>(
                    hint: Text('Select Branch       '),
                    icon: Icon(Icons.arrow_downward),
                    value: branch,
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      color: Color(0xFFFC2542),
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        branch = newValue;
                      });
                    },
                    items: <String>['INFT', 'ETRX', 'MCA', 'CS']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: DropdownButton<String>(
                    hint: Text('Select Year        '),
                    icon: Icon(Icons.arrow_downward),
                    value: year,
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      color: Color(0xFFFC2542),
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        year = newValue;
                      });
                    },
                    items: <String>['1st Year', '2nd Year', '3rd Year', '4th Year']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: DropdownButton<String>(
                    hint: Text('Select Divison    '),
                    icon: Icon(Icons.arrow_downward),
                    value: batch,
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      color: Color(0xFFFC2542),
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        batch = newValue;
                      });
                    },
                    items: <String>['D10', 'D5', 'D15', 'D20']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            onSubmit(context);
        },
        child: FaIcon(FontAwesomeIcons.arrowRight),
        backgroundColor: Color(0xFF000050),
      ),
    );
  }
}
