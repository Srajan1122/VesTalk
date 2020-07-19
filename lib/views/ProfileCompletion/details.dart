import 'package:flutter/material.dart';
import 'designations/Student.dart';
import 'designations/Teacher.dart';
import 'designations/Council.dart';

class Details extends StatefulWidget {
  final String designation;
  Details({@required this.designation});
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  handleFields(desig) {
    switch (desig) {
      case 'Student':
        {
          return Student();
        }
      case 'Teacher':
        {
          return Teacher();
        }
      case 'Council':
        {
          return Council();
        }
        break;
      default:
        {
          return Text('Something went wrong');
        }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return  Scaffold(
        body: handleFields(widget.designation),
      );
  }
}
