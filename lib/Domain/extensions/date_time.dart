import 'package:intl/intl.dart';

extension CustomDateTime on DateTime {
  String get date {
    String output = '';
    if (DateTime.now().difference(this).inDays > 7) {
      output = "$day ${DateFormat('MMMM').format(DateTime(0, month))} $year";
    } else {
      if (DateTime.now().difference(this).inHours > 24) {
        output = "${DateTime.now().difference(this).inDays} days ago";
      } else {
        if (DateTime.now().difference(this).inMinutes > 59) {
          output = "${DateTime.now().difference(this).inHours} hours ago";
        } else {
          if (DateTime.now().difference(this).inSeconds > 59) {
            output = "${DateTime.now().difference(this).inMinutes} minutes ago";
          } else {
            output = "${DateTime.now().difference(this).inSeconds} seconds ago";
          }
        }
      }
    }
    return output;
  }
}
