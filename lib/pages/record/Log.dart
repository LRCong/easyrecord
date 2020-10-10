import 'package:easyrecord/db/db_helper.dart';

getOutcomeMainType(outComeType) {
  dbHelp.getOutcomeCategory().then((list) {
    print(list.length);
    for (int i = 0; i < list.length; i++) {
      Map map = list[i];
      outComeType.add(map);
    }
  });
}
