import '../pages/Tabs.dart';
import '../pages/recognition/GestureRecognition.dart';
import '../pages/recognition/Setting.dart';
import 'package:easyrecord/pages/recognition/StringPwSetting.dart';
import 'package:easyrecord/pages/recognition/GesturePwSetting.dart';
import 'package:easyrecord/pages/recognition/FingerPwSetting.dart';
import '../pages/recognition/StringPwRecognition.dart';

final routes = {
  "/StringPwRecognition": (context) => StringPwRecognitionPage(),
  "/home": (context) => Tabs(),
  "/GesturePwRecognition": (context) => GesturePwRecognitionPage(),
  "/PwSetting": (context) => PwSetting(),
  "/StringPwSetting": (context) => StringPwSettingPage(),
  "/GesturePwSetting": (context) => GesturePwSettingPage(),
  "/FingerPwSetting": (context) => FingerPwSettingPage()
};
