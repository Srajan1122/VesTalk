import 'package:shared_preferences/shared_preferences.dart';

getUserId() async {
  String uid;
  await SharedPreferences.getInstance()
      .then((value) => {uid = (value.getString("id") ?? '')});
  return uid;
}
