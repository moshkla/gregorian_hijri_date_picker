import 'package:flutter/material.dart';
import 'package:gregorian_hijri_date_picker/extensions.dart';
import 'package:gregorian_hijri_date_picker/hijri_calendar_view.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/core.dart';

import 'gregorian_calendar_view.dart';

class CustomSwitchMeladiHijriPicker {
  static Future<void> show({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    required Function(String formattedDate) onDateSelected,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        final initialHijri = DateFormat('yyyy-MM-dd').format(initialDate);
        HijriDateTime? initialHijriDate;

        if (initialHijri.isHijriDate) {
          initialHijriDate = HijriDateTime(
            int.parse(initialHijri.split('-')[0]),
            int.parse(initialHijri.split('-')[1]),
            int.parse(initialHijri.split('-')[2]),
          );
        } else {
          final HijriCalendar initialHijriCalendar = HijriCalendar.fromDate(
            initialDate,
          );
          initialHijriDate = HijriDateTime(
            initialHijriCalendar.hYear,
            initialHijriCalendar.hMonth,
            initialHijriCalendar.hDay,
          );
        }

        final HijriCalendar firstHijriDate = HijriCalendar.fromDate(firstDate);
        final HijriCalendar lastHijriDate = HijriCalendar.fromDate(lastDate);

        return CalendarSwitchBody(
          onDateSelected: onDateSelected,
          initialDate: initialDate,
          initialHijriDate: initialHijriDate,
          firstDate: firstDate,
          lastDate: lastDate,
          firstDateHijri: HijriDateTime(
            firstHijriDate.hYear,
            firstHijriDate.hMonth,
            firstHijriDate.hDay,
          ),
          intitialIndex: initialHijri.isHijriDate ? 1 : 0,
          lastDateHijri: HijriDateTime(
            lastHijriDate.hYear,
            lastHijriDate.hMonth,
            lastHijriDate.hDay,
          ),
        );
      },
    );
  }
}

class CalendarSwitchBody extends StatefulWidget {
  const CalendarSwitchBody({
    super.key,
    required this.onDateSelected,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.firstDateHijri,
    required this.lastDateHijri,
    required this.initialHijriDate,
    this.intitialIndex,
  });
  final Function(String formattedDate) onDateSelected;

  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final HijriDateTime initialHijriDate;
  final HijriDateTime firstDateHijri;
  final HijriDateTime lastDateHijri;
  final int? intitialIndex;

  @override
  State<CalendarSwitchBody> createState() => _CalendarSwitchBodyState();
}

class _CalendarSwitchBodyState extends State<CalendarSwitchBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.intitialIndex ?? 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 650,
        width: MediaQuery.sizeOf(context).width,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DefaultTabController(
                length: 2,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    controller: _tabController,
                    indicatorColor: Colors.white,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        20,
                      ), // Rounded corners
                      color: Colors.white,
                    ),
                    tabAlignment: TabAlignment.center,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.white,
                    labelStyle: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(color: Colors.amber),
                    dividerHeight: 0,
                    unselectedLabelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    tabs: [
                      Tab(text: 'gregorian'),
                      Tab(text: 'hijri'),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 600,
                width: double.infinity,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    GregorianCalendarView(
                      initialDate: widget.initialDate,
                      firstDate: widget.firstDate,
                      lastDate: widget.lastDate,
                      onDateSelected: widget.onDateSelected,
                    ),
                    HijriCalendarView(
                      initialDate: widget.initialHijriDate,
                      firstDateHijri: widget.firstDateHijri,
                      lastDateHijri: widget.lastDateHijri,
                      onDateSelected: widget.onDateSelected,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
