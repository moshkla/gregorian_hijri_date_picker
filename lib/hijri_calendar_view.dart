import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/core.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class HijriCalendarView extends StatelessWidget {
  const HijriCalendarView({
    super.key,
    required this.onDateSelected,
    required this.initialDate,
    required this.firstDateHijri,
    required this.lastDateHijri,
  });
  final Function(String formattedDate) onDateSelected;
  final HijriDateTime initialDate;
  final HijriDateTime firstDateHijri;
  final HijriDateTime lastDateHijri;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.all(16),
      content: SizedBox(
        height: 500,
        width: MediaQuery.sizeOf(context).width,
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerTheme: DividerThemeData(
              color: Theme.of(context).primaryColor,
            ),
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              surface: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColor,
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          child: SfHijriDateRangePicker(
            selectionShape: DateRangePickerSelectionShape.rectangle,
            headerStyle: DateRangePickerHeaderStyle(
              textAlign: TextAlign.center,
              backgroundColor: Colors.white,
              textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.white,
            // confirmText: context.localizations.apply,
            // cancelText: context.localizations.cancel,
            headerHeight: 80,
            monthFormat: 'MMMM yyyy',
            monthViewSettings: HijriDatePickerMonthViewSettings(
              dayFormat: 'EEE',
              viewHeaderStyle: DateRangePickerViewHeaderStyle(
                textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            monthCellStyle: HijriDatePickerMonthCellStyle(
              textStyle: Theme.of(context).textTheme.bodyLarge,
            ),
            showNavigationArrow: true,
            initialDisplayDate: initialDate,
            initialSelectedDate: initialDate,
            minDate: firstDateHijri,
            maxDate: lastDateHijri,
            showActionButtons: true,
            onSubmit: (dateRangePickerSelectionChangedArgs) {
              if (dateRangePickerSelectionChangedArgs is HijriDateTime) {
                final selectedDate = dateRangePickerSelectionChangedArgs;

                final formatted =
                    "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
                onDateSelected(formatted);
                Navigator.of(context).pop();
              }
            },
            onCancel: Navigator.of(context).pop,
          ),
        ),
      ),
    );
  }
}
