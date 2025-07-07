import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class GregorianCalendarView extends StatelessWidget {
  const GregorianCalendarView({
    super.key,
    required this.onDateSelected,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
  });
  final Function(String formattedDate) onDateSelected;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.all(16),
      content: Container(
        color: Colors.white,
        height: 500,
        width: 400,
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
          child: SfDateRangePicker(
            backgroundColor: Colors.white,
            initialSelectedDate: initialDate,
            initialDisplayDate: initialDate,
            minDate: firstDate,
            maxDate: lastDate,
            headerStyle: DateRangePickerHeaderStyle(
              textAlign: TextAlign.center,
              backgroundColor: Colors.white,
              textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            showActionButtons: true,
            selectionShape: DateRangePickerSelectionShape.rectangle,
            headerHeight: 80,
            // confirmText: context.localizations.apply,
            // cancelText: context.localizations.cancel,
            showNavigationArrow: true,
            monthCellStyle: DateRangePickerMonthCellStyle(
              textStyle: Theme.of(context).textTheme.bodyLarge,
            ),
            monthViewSettings: DateRangePickerMonthViewSettings(
              dayFormat: 'EEE',
              viewHeaderStyle: DateRangePickerViewHeaderStyle(
                textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onSubmit: (dateRangePickerSelectionChangedArgs) {
              if (dateRangePickerSelectionChangedArgs is DateTime) {
                final selectedDate = dateRangePickerSelectionChangedArgs;
                final formattedDate = DateFormat(
                  'yyyy-MM-dd',
                ).format(selectedDate);
                // final localizedDate = DateFormat(
                //   'yyyy-MM-dd',
                //   locale.languageCode,
                // ).format(selectedDate);
                onDateSelected(formattedDate);
                Navigator.pop(context);
              }
            },
            onCancel: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
