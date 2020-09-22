import 'package:shared_preferences/shared_preferences.dart';

setStringPw(String pw) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('stringPw', pw);
}

setGesturePw(String pw) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('gesturePw', pw);
}

setWhichPw(int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // print(value);
  await prefs.setInt('whichPw', value);
}

Future<String> getStringPw() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var pw = prefs.getString('stringPw');
  return pw;
}

Future<String> getGesturePw() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var pw = prefs.getString('gesturePw');
  return pw;
}

Future<int> getWhichPw() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var whichPw = prefs.getInt('whichPw');
  return whichPw;
}
