import 'package:app/helpers/app_colors.dart';
import 'package:app/pages/launch_page.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';

class Page404Page extends StatelessWidget {
  final String? sms;

  Page404Page({
    this.sms,
  }); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48,
                  color: MyColors.SecondaryBlue,
                ),
                SizedBox(height: 20),
                CustomText(
                  text: sms ??
                      'The app is not working at the moment',
                  color: MyColors.SecondaryBlue,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                CupertinoButton(
                  color: MyColors.blue,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.refresh,
                        color: MyColors.white,
                      ),
                      SizedBox(width: 8),
                      CustomText(
                        text: 'Relaunch',
                        color: MyColors.white,
                      ),
                    ],
                  ),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return LaunchPage();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
