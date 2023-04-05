import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';

final String baseUrl = dotenv.get("BASE_URL");
final String baseImageUrl = dotenv.get("BASE_URL_IMAGE");
final String apiKey = dotenv.get("API_KEY");

const Color kPrimaryColor = Color(0xFF242A32);
const Color kGreyColor = Color(0xFF67686D);
const Color kGreyBoldColor = Color(0xFF92929D);
const Color kGreySoftColor = Color(0xFF3A3F47);
const Color kBlueColor = Color(0xFF0296E5);
const Color kOrangeColor = Color(0xFFFF8700);

// text theme
final kTextTheme = TextTheme(
  headlineSmall: kHeading5,
  titleLarge: kHeading6,
  titleMedium: kSubtitle,
  bodyMedium: kBodyText,
);

// Space
Widget kVerticalSpace(double height) => SizedBox(height: height);
Widget kHorizontalSpace(double width) => SizedBox(width: width);

// text style
final TextStyle kHeading5 =
    GoogleFonts.poppins(fontSize: 23, fontWeight: regular);
final TextStyle kHeading6 = GoogleFonts.poppins(
    fontSize: 18, fontWeight: semibold, letterSpacing: 0.15);
final TextStyle kSubtitle =
    GoogleFonts.poppins(fontSize: 15, fontWeight: regular, letterSpacing: 0.15);
final TextStyle kBodyText =
    GoogleFonts.poppins(fontSize: 13, fontWeight: regular, letterSpacing: 0.25);

// FontWeight
FontWeight thin = FontWeight.w100;
FontWeight extralight = FontWeight.w200;
FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semibold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extrabold = FontWeight.w800;
