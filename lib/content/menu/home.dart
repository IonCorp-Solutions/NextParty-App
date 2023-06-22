import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:next_party_application/api/supplies/events/event_model.dart';
import 'package:next_party_application/content/menu/events/event_detail.dart';
import 'package:next_party_application/theme/loading.dart';
import 'package:next_party_application/theme/theme.dart';
import 'package:next_party_application/api/supplies/auth/user_service.dart';
import 'events/create_event.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UsersService usersService = UsersService();
  bool _isLoading = false;
  late List<Event> _events;
  late List<Event> _invitedEvents;

  @override
  void initState() {
    super.initState();
    loadEvents();
  }

  void updateOwnEvents(Event event) {
    setState(() {
      _events.insert(0, event);
    });
  }

  Future<void> loadEvents() async {
    setState(() {
      _isLoading = true;
    });
    _events = await usersService.ownEvents();
    _invitedEvents = await usersService.invitedEvents();
    setState(() {
      _events = _events.reversed.toList();
      _isLoading = false;
    });
    return;
  }

  void _detailParty(Event event, bool own) {
    Navigator.push(
      context,
      CupertinoPageRoute(
          builder: (context) => EventDetail(
                event: event,
                isEdit: own,
              )),
    );
  }

  void _createParty() {
    Navigator.push(
      context,
      CupertinoPageRoute(
          builder: (context) => CreateEvent(
                updateEvents: updateOwnEvents,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LoadingEffect.loading
        : Scaffold(
            backgroundColor: AppTheme.whiteColor,
            body: SafeArea(
              child: (SingleChildScrollView(
                  child: Padding(
                padding: AppTheme.paddingApp,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('My Events', style: AppTheme.homeTitle),
                        IconButton(
                            onPressed: _createParty,
                            icon: const Icon(Icons.add_circle_outline,
                                color: AppTheme.dodgerPrimaryColor, size: 28)),
                      ],
                    ),
                    AppTheme.spaceBoxH,
                    SizedBox(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        child: _events.isNotEmpty
                            ? ListView.separated(
                                shrinkWrap: false,
                                itemBuilder: (context, index) {
                                  return AppTheme.ownEventsCard(
                                      context,
                                      _events[index],
                                      () => _detailParty(_events[index], true));
                                },
                                itemCount: _events.length,
                                scrollDirection: Axis.horizontal,
                                controller: ScrollController()..addListener(() { }),
                                physics: const BouncingScrollPhysics(),
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return AppTheme.spaceBoxW;
                                },
                              )
                            : Container(
                                alignment: Alignment.center,
                                child: const Text(
                                    'You have not created any event yet',
                                    style: AppTheme.title),
                              )),
                    AppTheme.spaceBoxH,
                    Container(
                        alignment: Alignment.centerLeft,
                        child: const Text('Events you participate in',
                            style: AppTheme.homeTitle)),
                    AppTheme.spaceBoxH,
                    _invitedEvents.isEmpty
                        ? SizedBox(
                            height: 200,
                            child: Container(
                              alignment: Alignment.center,
                              child: const Text(
                                  'You have not been invited to any event yet',
                                  style: AppTheme.title),
                            ),
                          )
                        : SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return AppTheme.sharedEventsCard(
                                    context,
                                    _invitedEvents[index],
                                    () => _detailParty(
                                        _invitedEvents[index], false));
                              },
                              itemCount: _invitedEvents.length,
                              scrollDirection: Axis.vertical,
                              physics: const BouncingScrollPhysics(),
                              reverse: true,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return AppTheme.spaceBoxH;
                              },
                            ))
                  ],
                ),
              ))),
            ),
          );
  }
}
