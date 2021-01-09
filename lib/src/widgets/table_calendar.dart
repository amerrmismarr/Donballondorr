import 'package:Donballondor/src/services/api_service.dart';
import 'package:Donballondor/src/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class AppTableCalendar extends StatefulWidget with ChangeNotifier {
  @override
  _AppTableCalendarState createState() => _AppTableCalendarState();
}

class _AppTableCalendarState extends State<AppTableCalendar> {
  CalendarController controller;
  String formattedDate;
  String get newDate =>  formattedDate;

  @override
  void initState() {
    controller = CalendarController();
    var outputFormat = DateFormat("yyyy-MM-dd");
    formattedDate = outputFormat.format(DateTime.now());
    print(formattedDate);
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final apiService = Provider.of<ApiService>(context);
    return TableCalendar(
      calendarController: controller,
      initialCalendarFormat: CalendarFormat.week,
      calendarStyle: CalendarStyle(
        markersMaxAmount: 0,
        todayStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
          color: Colors.white,
        ),
      ),
      headerStyle: HeaderStyle(
        titleTextStyle: TextStyle(color: AppColors.notshinygold),
        centerHeaderTitle: true,
        formatButtonDecoration: BoxDecoration(
            color: AppColors.notshinygold,
            borderRadius: BorderRadius.circular(25.0)),
        formatButtonTextStyle: TextStyle(color: AppColors.darkblue),
        formatButtonShowsNext: false,
      ),
      onDaySelected: (date, events, event) {
        var outputFormat = DateFormat("yyyy-MM-dd");
        formattedDate = outputFormat.format(date);
        print(formattedDate);
        apiService.getFixtures(formattedDate, context);
        
       
      },
      builders: CalendarBuilders(
          selectedDayBuilder: (context, date, events) => Container(
              margin: const EdgeInsets.all(4.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color.fromRGBO(224, 176, 92, 1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                date.day.toString(),
                style: TextStyle(
                  color: Color.fromRGBO(13, 18, 38, 1),
                ),
              )),
          todayDayBuilder: (context, date, events) => Container(
              margin: const EdgeInsets.all(4.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color.fromRGBO(228, 188, 112, 1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                date.day.toString(),
                style: TextStyle(
                  color: Color.fromRGBO(13, 18, 38, 1),
                ),
              )),
          dayBuilder: (context, date, events) {
            return Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  date.day.toString(),
                  style: TextStyle(
                      color: Color.fromRGBO(224, 176, 92, 1),
                      fontWeight: FontWeight.bold),
                ));
          }),
    );
  }
}
