library event_calendar;

import 'dart:math';
import 'package:co_pet/cubits/user/pet/pet_list_cubit.dart';
import 'package:co_pet/cubits/user/schedule/schedule_list_cubit.dart';
import 'package:co_pet/domain/models/user/schedule/schedule_model.dart';
import 'package:co_pet/domain/repository/user/schedule/schedule_list_repository.dart';
import 'package:co_pet/domain/repository/user/user_login_repository.dart';
import 'package:co_pet/presentation/user/schedule/pet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

part 'color-picker.dart';

part 'timezone-picker.dart';

part 'appointment-editor.dart';

void main() => runApp(const MaterialApp(
      home: ScheduleScreen(),
      debugShowCheckedModeBanner: false,
    ));

//ignore: must_be_immutable
class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  ScheduleScreenState createState() => ScheduleScreenState();
}

List<Color> _colorCollection = <Color>[];
List<String> _colorNames = <String>[];
int _selectedColorIndex = 0;
int _selectedTimeZoneIndex = 0;
List<String> _timeZoneCollection = <String>[];
late DataSource _events;
Meeting? _selectedAppointment;
late DateTime _startDate;
late TimeOfDay _startTime;
late DateTime _endDate;
late TimeOfDay _endTime;
bool _isAllDay = false;
String _subject = '';
String _notes = '';
ScheduleListCubit scheduleListCubit = ScheduleListCubit();
String? userId;

class ScheduleScreenState extends State<ScheduleScreen> {
  ScheduleScreenState();
  late List<String> eventNameCollection;
  late List<Meeting> appointments;
  CalendarController calendarController = CalendarController();

  @override
  void initState() {
    getSchedule();
    appointments = getMeetingDetails();
    _events = DataSource(appointments);
    _selectedAppointment = null;
    _selectedColorIndex = 0;
    _selectedTimeZoneIndex = 0;
    _subject = '';
    _notes = '';
    super.initState();
  }

  Future<void> getSchedule() async {
    userId = await UserLoginRepository().getUserId();
    debugPrint("userId $userId");
    scheduleListCubit.getScheduleList(int.parse(userId!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            "Schedule",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: const PetScreen(),
                  withNavBar: false,
                );
              },
              icon: const Icon(Icons.pets),
              color: Colors.white,
            )
          ],
          backgroundColor: const Color.fromARGB(255, 0, 162, 255),
        ),
        body: SafeArea(
          child: BlocBuilder(
            bloc: scheduleListCubit,
            builder: (context, state) {
              if (state is ScheduleListLoaded) {
                appointments = state.data.data!;
                _events = DataSource(appointments);
              }
              return Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                  child: getEventCalendar(_events, onCalendarTapped));
            },
          ),
        ));
  }

//2023-12-05T20:40:07.921Z
  SfCalendar getEventCalendar(CalendarDataSource calendarDataSource,
      CalendarTapCallback calendarTapCallback) {
    return SfCalendar(
        view: CalendarView.month,
        controller: calendarController,
        allowedViews: const [
          CalendarView.week,
          CalendarView.timelineWeek,
          CalendarView.month
        ],
        dataSource: calendarDataSource,
        onTap: calendarTapCallback,
        appointmentBuilder: (context, calendarAppointmentDetails) {
          final Meeting meeting = calendarAppointmentDetails.appointments.first;
          return Container(
            color: meeting.background.withOpacity(0.8),
            child: Text(meeting.eventName),
          );
        },
        initialDisplayDate: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 0, 0, 0),
        monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        timeSlotViewSettings: const TimeSlotViewSettings(
            minimumAppointmentDuration: Duration(minutes: 60)));
  }

  void onCalendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement != CalendarElement.calendarCell &&
        calendarTapDetails.targetElement != CalendarElement.appointment) {
      return;
    }

    setState(() {
      _selectedAppointment = null;
      _isAllDay = false;
      _selectedColorIndex = 0;
      _selectedTimeZoneIndex = 0;
      _subject = '';
      _notes = '';
      if (calendarController.view == CalendarView.month) {
        calendarController.view = CalendarView.day;
      } else {
        if (calendarTapDetails.appointments != null &&
            calendarTapDetails.appointments!.length == 1) {
          final Meeting meetingDetails = calendarTapDetails.appointments![0];
          debugPrint("da ${calendarTapDetails.appointments![0]}");
          _startDate = meetingDetails.from;
          _endDate = meetingDetails.to;
          _isAllDay = meetingDetails.isAllDay;
          _selectedColorIndex =
              _colorCollection.indexOf(meetingDetails.background);
          _selectedTimeZoneIndex = meetingDetails.startTimeZone == ''
              ? 0
              : _timeZoneCollection.indexOf(meetingDetails.startTimeZone);
          _subject = meetingDetails.eventName == '(No title)'
              ? ''
              : meetingDetails.eventName;
          _notes = meetingDetails.description;
          debugPrint("iddddd ${meetingDetails.id}");
          _selectedAppointment = meetingDetails;
        } else {
          final DateTime date = calendarTapDetails.date!;
          _startDate = date;
          _endDate = date.add(const Duration(hours: 1));
        }
        _startTime =
            TimeOfDay(hour: _startDate.hour, minute: _startDate.minute);
        _endTime = TimeOfDay(hour: _endDate.hour, minute: _endDate.minute);
        Navigator.push<Widget>(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const AppointmentEditor()),
        );
      }
    });
  }

  List<Meeting> getMeetingDetails() {
    final List<Meeting> meetingCollection = <Meeting>[];
    eventNameCollection = <String>[];
    eventNameCollection.add('General Meeting');
    eventNameCollection.add('Plan Execution');
    eventNameCollection.add('Project Plan');
    eventNameCollection.add('Consulting');
    eventNameCollection.add('Support');
    eventNameCollection.add('Development Meeting');
    eventNameCollection.add('Scrum');
    eventNameCollection.add('Project Completion');
    eventNameCollection.add('Release updates');
    eventNameCollection.add('Performance Check');

    _colorCollection = <Color>[];
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF85461E));
    _colorCollection.add(const Color(0xFFFF00FF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));

    _colorNames = <String>[];
    _colorNames.add('Green');
    _colorNames.add('Purple');
    _colorNames.add('Red');
    _colorNames.add('Orange');
    _colorNames.add('Caramel');
    _colorNames.add('Magenta');
    _colorNames.add('Blue');
    _colorNames.add('Peach');
    _colorNames.add('Gray');

    _timeZoneCollection = <String>[];
    _timeZoneCollection.add('Default Time');
    _timeZoneCollection.add('AUS Central Standard Time');
    _timeZoneCollection.add('AUS Eastern Standard Time');
    _timeZoneCollection.add('Afghanistan Standard Time');
    _timeZoneCollection.add('Alaskan Standard Time');
    _timeZoneCollection.add('Arab Standard Time');
    _timeZoneCollection.add('Arabian Standard Time');
    _timeZoneCollection.add('Arabic Standard Time');
    _timeZoneCollection.add('Argentina Standard Time');
    _timeZoneCollection.add('Atlantic Standard Time');
    _timeZoneCollection.add('Azerbaijan Standard Time');
    _timeZoneCollection.add('Azores Standard Time');
    _timeZoneCollection.add('Bahia Standard Time');
    _timeZoneCollection.add('Bangladesh Standard Time');
    _timeZoneCollection.add('Belarus Standard Time');
    _timeZoneCollection.add('Canada Central Standard Time');
    _timeZoneCollection.add('Cape Verde Standard Time');
    _timeZoneCollection.add('Caucasus Standard Time');
    _timeZoneCollection.add('Cen. Australia Standard Time');
    _timeZoneCollection.add('Central America Standard Time');
    _timeZoneCollection.add('Central Asia Standard Time');
    _timeZoneCollection.add('Central Brazilian Standard Time');
    _timeZoneCollection.add('Central Europe Standard Time');
    _timeZoneCollection.add('Central European Standard Time');
    _timeZoneCollection.add('Central Pacific Standard Time');
    _timeZoneCollection.add('Central Standard Time');
    _timeZoneCollection.add('China Standard Time');
    _timeZoneCollection.add('Dateline Standard Time');
    _timeZoneCollection.add('E. Africa Standard Time');
    _timeZoneCollection.add('E. Australia Standard Time');
    _timeZoneCollection.add('E. South America Standard Time');
    _timeZoneCollection.add('Eastern Standard Time');
    _timeZoneCollection.add('Egypt Standard Time');
    _timeZoneCollection.add('Ekaterinburg Standard Time');
    _timeZoneCollection.add('FLE Standard Time');
    _timeZoneCollection.add('Fiji Standard Time');
    _timeZoneCollection.add('GMT Standard Time');
    _timeZoneCollection.add('GTB Standard Time');
    _timeZoneCollection.add('Georgian Standard Time');
    _timeZoneCollection.add('Greenland Standard Time');
    _timeZoneCollection.add('Greenwich Standard Time');
    _timeZoneCollection.add('Hawaiian Standard Time');
    _timeZoneCollection.add('India Standard Time');
    _timeZoneCollection.add('Iran Standard Time');
    _timeZoneCollection.add('Israel Standard Time');
    _timeZoneCollection.add('Jordan Standard Time');
    _timeZoneCollection.add('Kaliningrad Standard Time');
    _timeZoneCollection.add('Korea Standard Time');
    _timeZoneCollection.add('Libya Standard Time');
    _timeZoneCollection.add('Line Islands Standard Time');
    _timeZoneCollection.add('Magadan Standard Time');
    _timeZoneCollection.add('Mauritius Standard Time');
    _timeZoneCollection.add('Middle East Standard Time');
    _timeZoneCollection.add('Montevideo Standard Time');
    _timeZoneCollection.add('Morocco Standard Time');
    _timeZoneCollection.add('Mountain Standard Time');
    _timeZoneCollection.add('Mountain Standard Time (Mexico)');
    _timeZoneCollection.add('Myanmar Standard Time');
    _timeZoneCollection.add('N. Central Asia Standard Time');
    _timeZoneCollection.add('Namibia Standard Time');
    _timeZoneCollection.add('Nepal Standard Time');
    _timeZoneCollection.add('New Zealand Standard Time');
    _timeZoneCollection.add('Newfoundland Standard Time');
    _timeZoneCollection.add('North Asia East Standard Time');
    _timeZoneCollection.add('North Asia Standard Time');
    _timeZoneCollection.add('Pacific SA Standard Time');
    _timeZoneCollection.add('Pacific Standard Time');
    _timeZoneCollection.add('Pacific Standard Time (Mexico)');
    _timeZoneCollection.add('Pakistan Standard Time');
    _timeZoneCollection.add('Paraguay Standard Time');
    _timeZoneCollection.add('Romance Standard Time');
    _timeZoneCollection.add('Russia Time Zone 10');
    _timeZoneCollection.add('Russia Time Zone 11');
    _timeZoneCollection.add('Russia Time Zone 3');
    _timeZoneCollection.add('Russian Standard Time');
    _timeZoneCollection.add('SA Eastern Standard Time');
    _timeZoneCollection.add('SA Pacific Standard Time');
    _timeZoneCollection.add('SA Western Standard Time');
    _timeZoneCollection.add('SE Asia Standard Time');
    _timeZoneCollection.add('Samoa Standard Time');
    _timeZoneCollection.add('Singapore Standard Time');
    _timeZoneCollection.add('South Africa Standard Time');
    _timeZoneCollection.add('Sri Lanka Standard Time');
    _timeZoneCollection.add('Syria Standard Time');
    _timeZoneCollection.add('Taipei Standard Time');
    _timeZoneCollection.add('Tasmania Standard Time');
    _timeZoneCollection.add('Tokyo Standard Time');
    _timeZoneCollection.add('Tonga Standard Time');
    _timeZoneCollection.add('Turkey Standard Time');
    _timeZoneCollection.add('US Eastern Standard Time');
    _timeZoneCollection.add('US Mountain Standard Time');
    _timeZoneCollection.add('UTC');
    _timeZoneCollection.add('UTC+12');
    _timeZoneCollection.add('UTC-02');
    _timeZoneCollection.add('UTC-11');
    _timeZoneCollection.add('Ulaanbaatar Standard Time');
    _timeZoneCollection.add('Venezuela Standard Time');
    _timeZoneCollection.add('Vladivostok Standard Time');
    _timeZoneCollection.add('W. Australia Standard Time');
    _timeZoneCollection.add('W. Central Africa Standard Time');
    _timeZoneCollection.add('W. Europe Standard Time');
    _timeZoneCollection.add('West Asia Standard Time');
    _timeZoneCollection.add('West Pacific Standard Time');
    _timeZoneCollection.add('Yakutsk Standard Time');

    final DateTime today = DateTime.now();
    final Random random = Random();
    // for (int month = -1; month < 2; month++) {
    //   for (int day = -5; day < 5; day++) {
    //     for (int hour = 9; hour < 18; hour += 5) {
    //       meetingCollection.add(Meeting(
    //         from: today
    //             .add(Duration(days: (month * 30) + day))
    //             .add(Duration(hours: hour)),
    //         to: today
    //             .add(Duration(days: (month * 30) + day))
    //             .add(Duration(hours: hour + 2)),
    //         background: _colorCollection[random.nextInt(9)],
    //         startTimeZone: '',
    //         endTimeZone: '',
    //         description: '',
    //         isAllDay: false,
    //         eventName: eventNameCollection[random.nextInt(7)],
    //       ));
    //       debugPrint(
    //           "today ${today.add(Duration(days: (month * 30) + day)).add(Duration(hours: hour))}");
    //     }
    //   }
    // }

    return meetingCollection;
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Meeting> source) {
    appointments = source;
  }

  int id(int index) => appointments![index].id;

  @override
  bool isAllDay(int index) => appointments![index].isAllDay;

  @override
  String getSubject(int index) => appointments![index].eventName;

  @override
  String getStartTimeZone(int index) => appointments![index].startTimeZone;

  @override
  String getNotes(int index) => appointments![index].description;

  @override
  String getEndTimeZone(int index) => appointments![index].endTimeZone;

  @override
  Color getColor(int index) => appointments![index].background;

  @override
  DateTime getStartTime(int index) => appointments![index].from;

  @override
  DateTime getEndTime(int index) => appointments![index].to;
}
