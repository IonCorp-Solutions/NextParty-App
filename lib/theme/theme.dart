import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:next_party_application/api/supplies/events/event_model.dart';

class AppTheme {
  AppTheme._();

  static const String fontName = 'Gilroy';

  static const Color primaryColor = Color(0xff0950ff);
  static const Color darkPrimaryColor = Color(0xff007dba);
  static const Color lightBlue = Color(0xFF019fe1);
  static const Color dodgerPrimaryColor = Color(0xff00B0FF);
  static const Color lightPurpleColor = Color(0xFF6285e6);
  static const Color lightPrimaryColor = Color(0xffc4d4fe);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color greyColor = Color(0xFFccced1);
  static const Color darkGreyColor = Color(0xFF9799a1);
  static const Color lightTextColor = Color(0xFF7c7f88);
  static const Color textColor = Color(0xFF4b4d53);
  static const Color blackColor = Color(0xFF1b1b1d);

  static const EdgeInsets paddingTop = EdgeInsets.only(top: 20);
  static const EdgeInsets paddingBottom = EdgeInsets.only(bottom: 20);
  static const EdgeInsets paddingApp = EdgeInsets.all(24);
  static const EdgeInsets paddingHorizontal =
      EdgeInsets.symmetric(horizontal: 24);
  static const EdgeInsets paddingCard = EdgeInsets.all(16);

  static String _getMonth(int i) {
    switch (i) {
      case 1:
        return 'Ene';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Abr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Ago';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      default:
        return 'Dic';
    }
  }

  static String uppercase(String text) {
    return text.toUpperCase();
  }

  // regular = 400 || medium = 500 || bold = 700

  static const TextStyle loadingText = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 64,
    letterSpacing: 0.27,
    color: lightBlue,
  );
  static const TextStyle headline = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 32,
    letterSpacing: 0.27,
    color: blackColor,
  );
  static const TextStyle head = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w700,
    fontSize: 22,
    letterSpacing: 0.1,
    color: primaryColor,
  );
  static const TextStyle profileName = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w700,
    fontSize: 25,
    color: blackColor,
  );
  static const TextStyle title = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: blackColor,
  );
  static const TextStyle subtitle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: blackColor,
  );
  static const TextStyle detailTitle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w700,
    fontSize: 18,
    letterSpacing: 0.18,
    color: blackColor,
  );
  static const TextStyle detailSubtitle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: blackColor,
  );
  static const TextStyle body = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: 0.1,
    color: blackColor,
  );
  static const TextStyle caption = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: 0.2,
    color: dodgerPrimaryColor,
  );
  static const TextStyle noCaption = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: 0.2,
    color: lightTextColor,
  );
  static const TextStyle button = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w700,
    fontSize: 16,
    letterSpacing: 1.25,
    color: whiteColor,
  );
  static const TextStyle buttonOut = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w700,
    fontSize: 16,
    letterSpacing: 1.25,
    color: dodgerPrimaryColor,
  );
  static const TextStyle buttonCancel = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w700,
    fontSize: 16,
    letterSpacing: 1.25,
    color: darkGreyColor,
  );
  static const TextStyle homeTitle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w600,
    fontSize: 24,
    letterSpacing: 1.25,
    color: blackColor,
  );
  static const TextStyle backButton = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 18,
    letterSpacing: 1.25,
    color: whiteColor,
  );
  static const TextStyle input = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: 1.25,
    color: darkGreyColor,
  );
  static const TextStyle hintTextStyle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: 1.25,
    color: greyColor,
  );
  static const TextStyle eventCardTitleStyle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w700,
    fontSize: 20,
    letterSpacing: 1.25,
    color: blackColor,
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle eventCardSubtitleStyle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: 1,
    overflow: TextOverflow.ellipsis,
    color: textColor,
  );
  static const TextStyle eventCardDayStyle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w600,
    fontSize: 22,
    letterSpacing: 1.5,
    color: blackColor,
  );
  static const TextStyle eventCardMonthStyle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    letterSpacing: 1,
    color: darkGreyColor,
  );

  static const OutlineInputBorder basicIB = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: greyColor));
  static const OutlineInputBorder focusedIB = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: dodgerPrimaryColor));
  static InputDecoration inputDecoration(text,IconData icon) => InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        enabledBorder: basicIB,
        focusedBorder: focusedIB,
        border: basicIB,
        hintText: text,
        hintStyle: hintTextStyle,
        prefixIcon: Icon(icon, color: greyColor),
      );

  static TextField textField(
      TextEditingController controller,
      String text,
      IconData icon,
      keyboardType,
      onTap,
      obscure
      ) =>
      TextField(
        controller: controller,
        obscureText: obscure,
        style: input,
        keyboardType: keyboardType,
        decoration: inputDecoration(text, icon),
        readOnly: keyboardType == TextInputType.datetime ? true : false,
        onTap: onTap,
      );

  static SizedBox elevatedButton(text, onPressed) => SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: dodgerPrimaryColor,
            elevation: 2,
          ),
          onPressed: onPressed,
          child: Text(uppercase(text), style: button),
        ),
      );

  static Container elevatedButtonOut(text, onPressed) => Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(
              color: dodgerPrimaryColor, width: 2, style: BorderStyle.solid),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: whiteColor,
            elevation: 0,
          ),
          onPressed: onPressed,
          child: Text(uppercase(text), style: buttonOut),
        ),
      );

  static Row captionRowForPage(text, link, context, StatefulWidget page) => Row(
        children: [
          Text(text, style: noCaption),
          TextButton(
            child: Text(link, style: caption),
            onPressed: () {
              Navigator.push(
                  context, CupertinoPageRoute(builder: (context) => page));
            },
          ),
        ],
      );
  static Row captionRowForFunction(text, link, context, function) => Row(
        children: [
          Text(text, style: noCaption),
          TextButton(
            onPressed: function,
            child: Text(link, style: caption),
          ),
        ],
      );

  static const SizedBox spaceBoxH = SizedBox(height: 20);
  static const SizedBox spaceBoxW = SizedBox(width: 20);
  static SizedBox spaceBoxNW(double n) => SizedBox(width: n);
  static SizedBox spaceBoxNH(double n) => SizedBox(height: n);

  static const BorderRadius borderRadius = BorderRadius.all(Radius.circular(8));
  static const BorderRadius cardRadius = BorderRadius.all(Radius.circular(10));

  static SizedBox ownEventsCard(BuildContext context, Event event, detail) =>
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: InkWell(
          splashColor: dodgerPrimaryColor,
          splashFactory: InkRipple.splashFactory,
          borderRadius: cardRadius,
          onTap: detail,
          child: Card(
            shape: const RoundedRectangleBorder(borderRadius: cardRadius),
            elevation: 4,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Image(
                        image: const AssetImage('assets/utils/party.jpg'),
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 200,
                      ),
                      event.date != null
                          ? Positioned(
                              bottom: 20,
                              left: 20,
                              child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: const BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: borderRadius,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(event.date?.day.toString() ?? '1',
                                          style: eventCardDayStyle),
                                      Text(_getMonth(event.date?.month ?? 0),
                                          style: eventCardMonthStyle),
                                    ],
                                  )
                                  // child: Column[],
                                  ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                ListTile(
                  title: Text(
                    event.name,
                    style: eventCardTitleStyle,
                  ),
                  subtitle: Text(
                    event.description,
                    style: eventCardSubtitleStyle,
                  ),
                  trailing: SizedBox(
                      width: 100,
                      child: Stack(
                        children: List.generate(
                          event.guests ?? 0,
                          (i) => Positioned(
                            top:
                                18, // adjust the spacing between images as needed
                            right: i * 18.0,
                            child: Align(
                              alignment: i % 2 == 0
                                  ? Alignment.topLeft
                                  : Alignment.topRight,
                              child: const Image(
                                image: AssetImage('assets/utils/profile.png'),
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      );

  static message(BuildContext context, String text) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(text),
        backgroundColor: lightBlue,
      ));

  static ListTile sharedEventsCard(BuildContext context, Event event, detail) =>
      ListTile(
        leading: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          child: Image(
            image: AssetImage(event.partyImage),
            width: 50,
            height: 80,
            fit: BoxFit.fitHeight,
          ),
        ),
        title: Text(
          event.name,
          style: eventCardTitleStyle,
        ),
        subtitle: Text(
          event.description,
          style: eventCardSubtitleStyle,
        ),
        trailing: IconButton(
          onPressed: detail,
          icon: const Icon(CupertinoIcons.arrow_right_circle,
              color: dodgerPrimaryColor, size: 28),
        ),
      );

  static bool isEmail(String input) {
    final RegExp regex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\])|(([a-zA-Z\-\d]+\.)+[a-zA-Z]{2,}))$',
      caseSensitive: false,
      multiLine: false,
    );
    return regex.hasMatch(input);
  }
}
