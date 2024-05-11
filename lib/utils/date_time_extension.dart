import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String format() => DateFormat('MMMM dd EEEE HH:mm').format(this);
}
