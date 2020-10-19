import 'package:easyrecord/pages/Analysis/AnalysisBar.dart';
import 'package:easyrecord/pages/Analysis/EditItem.dart';
import 'package:easyrecord/pages/recognition/FingerPwRecognition.dart';

import '../pages/Tabs.dart';
import '../pages/recognition/GestureRecognition.dart';
import '../pages/recognition/Setting.dart';
import 'package:easyrecord/pages/recognition/StringPwSetting.dart';
import 'package:easyrecord/pages/recognition/GesturePwSetting.dart';
import 'package:easyrecord/pages/recognition/FingerPwSetting.dart';
import '../pages/recognition/StringPwRecognition.dart';
import '../pages/record/Record.dart';
import '../pages/record/setting.dart';
import '../pages/chart/ChartBar.dart';

final routes = {
  "/StringPwRecognition": (context) => StringPwRecognitionPage(),
  "/home": (context) => Tabs(),
  "/GesturePwRecognition": (context) => GesturePwRecognitionPage(),
  "/PwSetting": (context) => PwSetting(),
  "/StringPwSetting": (context) => StringPwSettingPage(),
  "/GesturePwSetting": (context) => GesturePwSettingPage(),
  "/FingerPwSetting": (context) => FingerPwSettingPage(),
  "/FingerPwRecognition": (context) => FingerPwRecognitionPage(),
  "/Record": (context) => RecordPage(),
  "/RecordSetting": (context) => RecordSettingPage(),
  "/Chart": (context) => ChartBarPage(),
  "/Analysis": (context) => AnalysisPage(),
  "/Edit": (context) => EditItemPage(),
};
