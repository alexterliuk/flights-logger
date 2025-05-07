import 'extract_int.dart';

List<int> extractIds(String idsStr) {
  try {
    List<int> ids = [];
    List<String> chars = idsStr.split(',');

    for (final c in chars) {
      var integer = extractInt(c);

      if (integer != -1) {
        ids.add(integer);
      }
    }

    return ids;
  } catch (e) {
    return [];
  }
}
