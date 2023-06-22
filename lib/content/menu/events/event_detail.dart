import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:next_party_application/api/supplies/events/event_model.dart';
import 'package:next_party_application/api/supplies/events/event_service.dart';
import 'package:next_party_application/theme/loading.dart';

import 'package:next_party_application/theme/theme.dart';
import 'edit_event.dart';

class EventDetail extends StatefulWidget {
  final Event event;
  final bool isEdit;
  const EventDetail({super.key, required this.event, required this.isEdit});
  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  EventsService eventsService = EventsService();

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  void _editEvent() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => EditEvent(
          updateEvents: updateEvent,
          event: widget.event,
        ),
      ),
    );
  }

  updateEvent(Event event) {
    if (widget.event.id == event.id) {
      setState(() {
        widget.event.name = event.name;
        widget.event.description = event.description;
        widget.event.date = event.date;
        widget.event.location = event.location;
      });
    }
  }

  _addGuest() async {
    if (emailController.text.isEmpty ||
        AppTheme.isEmail(emailController.text) == false) {
      AppTheme.message(context, 'Valid email is required');
      return;
    }
    Navigator.canPop(context) ? Navigator.pop(context) : null;
    LoadingEffect.showLoading(context);
    var response =
        await eventsService.inviteFriend(widget.event.id, emailController.text);
    if (response) {
      if (!mounted) return;
      LoadingEffect.hideLoading(context);
      setState(() {
        widget.event.guests = widget.event.guests! + 1;
      });
      emailController.clear();
      AppTheme.message(context, 'Friend added successfully');
      return;
    }
    if (!mounted) return;
    LoadingEffect.hideLoading(context);
    AppTheme.message(context, 'Something went wrong, check the email');
    return;
  }

  _addWishlist() async {
    if (nameController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        quantityController.text.isEmpty) {
      AppTheme.message(context, 'All fields are required');
      Navigator.canPop(context) ? Navigator.pop(context) : null;
      return;
    }

    var quantity = int.tryParse(quantityController.text);

    if (quantity == null || quantity < 1 || quantity > 20) {
      AppTheme.message(context, 'Quantity must be between 1 and 20');
      Navigator.canPop(context) ? Navigator.pop(context) : null;
      return;
    }

    LoadingEffect.showLoading(context);
    var response = await eventsService.addItem(
      widget.event.id,
      Item(
        name: nameController.text,
        description: descriptionController.text,
        quantity: quantity,
      ),
    );

    if (response) {
      if (!mounted) return;
      LoadingEffect.hideLoading(context);
      setState(() {
        Wishlist temp = widget.event.wishlist;
        setState(() {
          temp.items.add(Item(
            name: nameController.text,
            description: descriptionController.text,
            quantity: quantity,
          ));
        });
        widget.event.wishlist = temp;
      });
      nameController.clear();
      descriptionController.clear();
      quantityController.clear();
      Navigator.canPop(context) ? Navigator.pop(context) : null;
      AppTheme.message(context, 'Item added successfully');
      return;
    }

    if (!mounted) return;
    LoadingEffect.hideLoading(context);
    AppTheme.message(context, 'Something went wrong, check the data');
    return;
  }

  showAddGuestDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add Guest'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: AppTheme.input,
                      decoration: AppTheme.inputDecoration(
                          'Email', CupertinoIcons.mail),
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel', style: AppTheme.buttonCancel),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                    child: const Text('Add', style: AppTheme.buttonOut),
                    onPressed: () {
                      _addGuest();
                    }),
              ],
            );
          },
        );
      },
    );
  }

  showAddWLDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Add Item to Wishlist', style: AppTheme.head),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                style: AppTheme.input,
                decoration: AppTheme.inputDecoration(
                    'Name', CupertinoIcons.shopping_cart),
              ),
              AppTheme.spaceBoxH,
              TextField(
                controller: descriptionController,
                keyboardType: TextInputType.text,
                style: AppTheme.input,
                decoration: AppTheme.inputDecoration(
                    'Description', CupertinoIcons.textformat),
              ),
              AppTheme.spaceBoxH,
              TextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                style: AppTheme.input,
                decoration:
                    AppTheme.inputDecoration('Quantity', CupertinoIcons.number),
              ),
              AppTheme.spaceBoxH,
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel', style: AppTheme.buttonCancel),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
            TextButton(
              child: const Text('Add Item', style: AppTheme.buttonOut),
              onPressed: () {
                _addWishlist();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topCenter,
                height: 250,
                decoration: const BoxDecoration(
                  color: AppTheme.primaryColor,
                ),
                child: Column(
                  children: [
                    AppTheme.spaceBoxNH(10),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: widget.isEdit
                                  ? const EdgeInsets.only(left: 20)
                                  : const EdgeInsets.all(20),
                              child: InkWell(
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.arrow_back_ios,
                                      color: AppTheme.whiteColor,
                                    ),
                                    Text(
                                      'Back',
                                      style: AppTheme.backButton,
                                    ),
                                  ],
                                ),
                                onTap: () => Navigator.pop(context),
                              ),
                            ),
                            widget.isEdit
                                ? IconButton(
                                    icon: const Icon(Icons.edit,
                                        color: AppTheme.whiteColor),
                                    onPressed: () => _editEvent(),
                                  )
                                : Container(),
                          ],
                        ),
                        AppTheme.spaceBoxNH(10),
                        widget.isEdit
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                        CupertinoIcons.person_add_solid,
                                        color: AppTheme.whiteColor),
                                    onPressed: showAddGuestDialog,
                                  ),
                                ],
                              )
                            : Container(),
                        AppTheme.spaceBoxNH(10),
                        widget.isEdit
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                        CupertinoIcons.square_favorites_fill,
                                        color: AppTheme.whiteColor),
                                    onPressed: showAddWLDialog,
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -50),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    color: AppTheme.whiteColor,
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: ListTile(
                          title: const Text(
                            "CREATED BY",
                            style: AppTheme.detailTitle,
                          ),
                          subtitle: Text(
                            widget.event.owner ?? '',
                            style: AppTheme.detailSubtitle,
                            overflow: TextOverflow.ellipsis,
                          ),
                          leading: const CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('assets/utils/profileL.png'),
                          ),
                        ),
                      ),
                      AppTheme.spaceBoxNH(10),
                      Padding(
                        padding: AppTheme.paddingHorizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTheme.spaceBoxH,
                            Text(
                              widget.event.name,
                              style: AppTheme.head,
                            ),
                            AppTheme.spaceBoxNH(10),
                            ListTile(
                              title: Text(
                                widget.event.getEventDate != ''
                                    ? widget.event.getEventDate
                                    : 'This event has no date',
                                style: AppTheme.detailTitle,
                              ),
                              subtitle: Text(
                                widget.event.getEventTime != ''
                                    ? widget.event.getEventTime
                                    : 'This event has no time',
                                style: AppTheme.detailSubtitle,
                              ),
                              leading: const Icon(
                                Icons.calendar_today,
                                color: AppTheme.dodgerPrimaryColor,
                                size: 30,
                              ),
                            ),
                            ListTile(
                              title: const Text(
                                "Address",
                                style: AppTheme.detailTitle,
                              ),
                              subtitle: Text(
                                widget.event.location ??
                                    "This event has no location",
                                style: AppTheme.detailSubtitle,
                              ),
                              leading: const Icon(
                                Icons.map,
                                color: AppTheme.dodgerPrimaryColor,
                                size: 30,
                              ),
                            ),
                            AppTheme.spaceBoxH,
                            const Text(
                              "Event Details",
                              style: AppTheme.head,
                            ),
                            AppTheme.spaceBoxNH(10),
                            Text(
                              widget.event.description,
                              style: AppTheme.body,
                              textAlign: TextAlign.justify,
                            ),
                            AppTheme.spaceBoxH,
                            widget.event.wishlist.active
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Wishlist",
                                            style: AppTheme.head,
                                          ),
                                          IconButton(
                                              onPressed: showAddWLDialog,
                                              icon: const Icon(
                                                Icons.add_circle_outline,
                                                color:
                                                    AppTheme.dodgerPrimaryColor,
                                              )),
                                        ],
                                      ),
                                      AppTheme.spaceBoxNH(10),
                                      widget.event.wishlist.items.isEmpty
                                          ? const Text(
                                              "No wishlist items",
                                              style: AppTheme.body,
                                            )
                                          : ListView.separated(
                                              itemCount: widget
                                                  .event.wishlist.items.length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  title: Text(
                                                    widget.event.wishlist
                                                        .items[index].name,
                                                    style: AppTheme.detailTitle,
                                                  ),
                                                  subtitle: Text(
                                                    widget
                                                        .event
                                                        .wishlist
                                                        .items[index]
                                                        .description,
                                                    style:
                                                        AppTheme.detailSubtitle,
                                                  ),
                                                  trailing: Text(
                                                    '#${widget.event.wishlist.items[index].quantity}',
                                                    style: AppTheme.detailTitle,
                                                  ),
                                                );
                                              },
                                              separatorBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return AppTheme.spaceBoxNH(10);
                                              },
                                            ),
                                    ],
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
