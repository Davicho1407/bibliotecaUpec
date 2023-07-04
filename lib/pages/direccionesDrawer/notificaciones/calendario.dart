import 'package:calendar_flutter_aj/calender_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Calendario extends StatefulWidget {
  const Calendario({super.key});

  @override
  State<Calendario> createState() => _CalendarioState();
}

class Event {
  final String title;
  final DateTime date;
  final String description;

  Event({
    required this.title,
    required this.date,
    required this.description,
  });
}

class _CalendarioState extends State<Calendario> {
  DateTime? calenderSelectedDate = DateTime.now();
  List<Event> events = [];

  void addEvent(Event event) {
    setState(() {
      events.add(event);
    });
  }

  void verEventos() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventosScreen(events: events),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              CalendarFlutterAj(
                selectedDate: (selectedDate) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Agregar evento'),
                      content: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(labelText: 'Título'),
                            controller: TextEditingController(),
                          ),
                          TextField(
                            decoration:
                                InputDecoration(labelText: 'Descripción'),
                            controller: TextEditingController(),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            String title = TextEditingController().text;
                            String description = TextEditingController().text;
                            Event event = Event(
                              title: title,
                              date: selectedDate,
                              description: description,
                            );
                            addEvent(event);
                            Navigator.pop(context);
                          },
                          child: Text('Guardar'),
                        ),
                      ],
                    ),
                  );

                  calenderSelectedDate = selectedDate;
                  if (kDebugMode) {
                    print(selectedDate);
                  }
                },
                backArrow: const DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0xffAED2EC),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_left_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                forwardArrow: const DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0xffAED2EC),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_right_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                calenderBackgroundColor: Colors.white,
                showCalenderGradient: true,
                showMonthGradient: true,
                showYearGradient: true,
                dividerColor: Colors.white,
                selectedDayColor: Colors.white,
                selectedDayWidget: Text(
                  calenderSelectedDate!.day.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
                calenderGradient: const LinearGradient(
                  colors: [
                    Color(0xff5F94B9),
                    Color(0xff6094BA),
                    Color(0xff85A3CB),
                    Color(0xff8DA4CE),
                    Color(0xff8898CE),
                    Color(0xff8395CD),
                  ],
                ),
                yearGradient: const LinearGradient(
                  colors: [
                    Color(0xff5F94B9),
                    Color(0xff6094BA),
                    Color(0xff85A3CB),
                    Color(0xff8DA4CE),
                    Color(0xff8898CE),
                    Color(0xff8395CD),
                  ],
                ),
                monthGradient: const LinearGradient(
                  colors: [
                    Color(0xff5F94B9),
                    Color(0xff6094BA),
                    Color(0xff85A3CB),
                    Color(0xff8DA4CE),
                    Color(0xff8898CE),
                    Color(0xff8395CD),
                  ],
                ),
                calenderSelectedDateBackgroundcolor: Colors.purple,
                showCalenderSelectedDateBackgroundcolor: true,
                calenderSelectedDateColor: Colors.white,
                calenderSelectedDateFontSize: 18,
                calenderSelectedDateBorderRadius: BorderRadius.circular(50),
                dayTextStyle: const TextStyle(
                  color: Colors.white,
                ),
                monthBackgroundColor: Colors.black,
                monthTextStyle: const TextStyle(
                  color: Colors.white,
                ),
                weekdaysTextStyle: const TextStyle(
                  color: Colors.white,
                ),
                yearBackgroundColor: Colors.black,
                yearTextStyle: const TextStyle(
                  color: Colors.white,
                ),
                calenderUnSelectedDatesColor: Colors.white,
                yearPopHeadingText: "año",
                yearPopHeadingTextStyle: const TextStyle(
                  color: Colors.white,
                ),
                yearsListTextStyle: const TextStyle(
                  color: Colors.white,
                ),
                monthPopHeadingText: "mes",
                monthPopHeadingTextStyle: const TextStyle(
                  color: Colors.white,
                ),
                monthsListTextStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
              ElevatedButton(
                onPressed: verEventos,
                child: const Text('Ver eventos'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventosScreen extends StatelessWidget {
  final List<Event> events;

  EventosScreen({required this.events});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eventos'),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          Event event = events[index];
          return ListTile(
            title: Text(event.title),
            subtitle: Text(event.description),
            // Otras propiedades y acciones del ListTile...
          );
        },
      ),
    );
  }
}
