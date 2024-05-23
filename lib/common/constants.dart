import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';

class ColorConstants {
  static Color mainGreen = HexColor("#05A01D");
  static Color secondaryGreen = HexColor("#138324");

  static Color mainGrey = HexColor("#d6d6d6");
  static Color secondaryGrey = HexColor("#E5E5E5");

  static Color mainText = HexColor("#19191C");
  static Color secondaryText = HexColor("##9e9e9e");

  static Color mainWhite = HexColor("#FFFFFF");

  static Color inputFill = HexColor("#FFFFFF");
}

class AssetConstants {
  static const String _imagesPath = 'assets/images';

  static const AssetImage cloverFullLogoGreen = AssetImage('$_imagesPath/clover_full_logo_green.png');
  static const AssetImage cloverFullLogoWhite = AssetImage('$_imagesPath/clover_full_logo_white.png');
  static const AssetImage cloverOnlyLogoGreen = AssetImage('$_imagesPath/clover_only_logo_green.png');
  static const AssetImage cloverOnlyLogoWhite = AssetImage('$_imagesPath/clover_only_logo_white.png');
  static const AssetImage cloverOnlyTextGreen = AssetImage('$_imagesPath/clover_only_text_green.png');
  static const AssetImage cloverOnlyTextWhite = AssetImage('$_imagesPath/clover_only_text_white.png');
  static const AssetImage cloverSadWhite = AssetImage('$_imagesPath/clover_sad_white.png');
  static const AssetImage googleLogo = AssetImage('$_imagesPath/google_logo.png');
  static const AssetImage whatsppLogo = AssetImage('$_imagesPath/whatsapp_logo.png');
  static const AssetImage gmailLogo = AssetImage('$_imagesPath/gmail_logo.png');
}

class AppwriteConstants {
  static const String projectId = "656ff145eafa16a1d209";
  static const String endpoint = "https://cloud.appwrite.io/v1";

  static const String databaseId = "657d49cf6096d196f80f";
  static const String usersCollectionId = "657493bfcb5f59850970";
  static const String prizeCollectionId = "65871885416470ba0ad2";
}
