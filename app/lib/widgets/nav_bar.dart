import 'package:app/helpers/app_colors.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/utils/size_config.dart' as utils;

navBar(String text){
  return CupertinoNavigationBar(
    leading: Image.asset(
      "assets/png/JL_LOGO_primary.PNG",
      height: utils.SizeConfig.blockSizeHorizontal * 15,
      fit: BoxFit.cover,
    ),
    trailing: CustomText(
      text: text,
      color: MyColors.blue,
    ),
    backgroundColor: MyColors.white,
  );
}

secondaryNavBar(String name) {
  return CupertinoNavigationBar(
    middle: Text(
      name,
      style: TextStyle(
        color: MyColors.black,
      ),
    ),
    backgroundColor: MyColors.white,
  );
}