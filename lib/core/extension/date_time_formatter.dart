import 'package:intl/intl.dart';

extension DateTimeFormatExtension on DateTime {
  // Format DateTime to "dd.MM.yyyy"
  String toDateFormat() {
    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    return formatter.format(this);
  }

  // Format DateTime to "HH:mm"
  String toTimeFormat() {
    final DateFormat formatter = DateFormat('HH:mm');
    return formatter.format(this);
  }
}
