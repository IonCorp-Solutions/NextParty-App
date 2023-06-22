import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:next_party_application/api/supplies/events/event_model.dart';
import 'package:next_party_application/theme/loading.dart';

import 'package:next_party_application/api/supplies/auth/user_service.dart';
import 'package:next_party_application/theme/theme.dart';

class CreateEvent extends StatefulWidget {
  final Function(Event) updateEvents;

  const CreateEvent({super.key, required this.updateEvents});
  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  UsersService usersService = UsersService();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  TimeOfDay time = TimeOfDay.now();

  Future<void> create(CreateEventDto eventDto) async {
    if (eventDto.name.isEmpty || eventDto.description.isEmpty) {
      AppTheme.message(
          context, 'Complete the name and description fields to continue');
      return;
    }

    if (eventDto.date != null && eventDto.date!.isBefore(DateTime.now())) {
      AppTheme.message(
          context, 'The date cannot be less than the current date');
      return;
    }

    LoadingEffect.showLoading(context);
    var response = await usersService.createEvent(eventDto);
    if (response != null) {
      if (!mounted) return;
      LoadingEffect.hideLoading(context);
      widget.updateEvents(response);
      AppTheme.message(context, 'Event created successfully');
    } else {
      if (!mounted) return;
      AppTheme.message(context, 'Error creating event');
    }
  }

  goBack() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget nameTextField = AppTheme.textField(nameController, 'Name*',
        Icons.cake, TextInputType.name, () => {}, false);
    Widget descriptionTextField = AppTheme.textField(descriptionController,
        'Description*', Icons.description, TextInputType.text, () => {}, false);
    Widget locationTextField = AppTheme.textField(
        locationController,
        'Location',
        CupertinoIcons.location_solid,
        TextInputType.streetAddress,
        () => {},
        false);
    Widget dateTextField = AppTheme.textField(
        dateController, 'Date', Icons.calendar_month, TextInputType.datetime,
        () async {
      FocusScope.of(context).unfocus();
      DateTime? date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100));
      dateController.text = date != null
          ? DateFormat('yyyy-MM-dd').format(date).toString()
          : dateController.text;
    }, false);
    Widget timeTextField = AppTheme.textField(timeController, 'Time',
        CupertinoIcons.time_solid, TextInputType.datetime, () async {
      FocusScope.of(context).unfocus();
      TimeOfDay? time =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (!mounted) return;
      timeController.text = time != null
          ? DateFormat('HH:mm aaa')
              .format(DateTime(0, 0, 0, time.hour, time.minute))
          : timeController.text;
      setState(() {
        this.time = time ?? this.time;
      });
    }, false);
    List<Widget> form = [
      nameTextField,
      descriptionTextField,
      locationTextField,
      dateTextField,
      timeTextField,
    ];

    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      body: SafeArea(
        child: Center(
            child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: AppTheme.paddingApp,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          color: AppTheme.lightBlue,
                          onPressed: () {
                            goBack();
                          },
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Create Event',
                          style: AppTheme.homeTitle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ListView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                          padding: AppTheme.paddingBottom,
                          child: form[index],
                        );
                      },
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: form.length,
                    ),
                    const SizedBox(height: 20),
                    AppTheme.elevatedButton("Create", () async {
                      var datePlusTime = (dateController.text.isEmpty ||
                              timeController.text.isEmpty)
                          ? null
                          : '${dateController.text} ${time.hour}:${time.minute}:00';

                      DateTime? date = datePlusTime != null
                          ? DateFormat('yyyy-MM-dd hh:mm:ss')
                              .parse(datePlusTime)
                          : null;

                      await create(CreateEventDto(
                        name: nameController.text,
                        description: descriptionController.text,
                        location: locationController.text.isEmpty
                            ? null
                            : locationController.text,
                        date: date,
                      ));
                    }),
                  ],
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
