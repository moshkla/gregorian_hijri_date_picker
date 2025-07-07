import 'package:hijri/hijri_calendar.dart';
import 'package:syncfusion_flutter_core/core.dart';

extension HijriDateValidation on String {
  bool get isHijriDate {
    try {
      final parts = split('-').map(int.parse).toList();
      if (parts.length != 3) return false;

      final hijriDate = HijriCalendar()
        ..hYear = parts[0]
        ..hMonth = parts[1]
        ..hDay = parts[2];
      return hijriDate.isValid();
    } catch (e) {
      return false; // Invalid format
    }
  }
}

extension DateTimeExtensions on DateTime {
  HijriDateTime toHijriDate() {
    final hijriCalendar = HijriCalendar.fromDate(this);
    return HijriDateTime(
      hijriCalendar.hYear,
      hijriCalendar.hMonth,
      hijriCalendar.hDay,
    );
  }
}
