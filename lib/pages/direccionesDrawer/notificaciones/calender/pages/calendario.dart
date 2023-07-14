// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class TableBasicsExample extends StatefulWidget {
  const TableBasicsExample({super.key});

  @override
  _TableBasicsExampleState createState() => _TableBasicsExampleState();
}

class Event {
  DateTime date;
  String description;

  Event({required this.date, required this.description});
}

class _TableBasicsExampleState extends State<TableBasicsExample> {
  @override
  void initState() {
    super.initState();
    loadEvents();
  }

  List<Event> _eventList = [];
  Future<void> loadEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> eventStrings = prefs.getStringList('eventList') ?? [];
    List<Event> events = eventStrings.map((eventString) {
      List<String> parts = eventString.split('|');
      DateTime date = DateTime.parse(parts[0]);
      String description = parts[1];
      return Event(date: date, description: description);
    }).toList();
    setState(() {
      _eventList = events;
    });
  }

  Future<void> saveEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> eventStrings = _eventList.map((event) {
      return '${event.date.toIso8601String()}|${event.description}';
    }).toList();
    await prefs.setStringList('eventList', eventStrings);
  }

  final _eventoController = TextEditingController();

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              // Use `selectedDayPredicate` to determine which day is currently selected.
              // If this returns true, then `day` will be marked as selected.

              // Using `isSameDay` is recommended to disregard
              // the time-part of compared DateTime objects.
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                // Call `setState()` when updating the selected day
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                _showAddEventDialog(selectedDay);
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              // No need to call `setState()` here
              _focusedDay = focusedDay;
            },
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _eventList.length,
              itemBuilder: (context, index) {
                final event = _eventList[index];
                final formattedDate = DateFormat.yMMMMd()
                    .format(event.date); // Formatear la fecha del evento

                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(formattedDate), // Mostrar la fecha del evento
                      Text(event
                          .description), // Mostrar la descripción del evento
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteEvent(
                          index); // Eliminar evento al presionar el botón de eliminación
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void _showAddEventDialog(DateTime selectedDay) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newEvent = '';
        return AlertDialog(
          title: Text('Agregar Evento'),
          content: TextFormField(
            controller: _eventoController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.greenAccent, width: 4),
                    borderRadius: BorderRadius.circular(12)),
                hintText: 'Añada un evento',
                fillColor: Colors.white),
            onChanged: (value) {
              newEvent =
                  value; // Actualizar el nuevo evento a medida que el usuario escribe
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Guardar'),
              onPressed: () {
                // Guardar el nuevo evento en la lista
                setState(() {
                  Event event = Event(date: selectedDay, description: newEvent);

                  _eventList.add(event);
                });
                saveEvents();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteEvent(int index) {
    setState(() {
      _eventList.removeAt(index); // Eliminar el evento de la lista
    });
    saveEvents();
  }
}
