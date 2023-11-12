import 'package:app/helpers/app_colors.dart';
import 'package:app/models/login_model.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:app/utils/size_config.dart' as utils;

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    this.userData,
  });

  final User? userData;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: secondaryNavBar("Profile"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30.0,
            ),
            Center(
              child: CircleAvatar(
                maxRadius: 50,
                backgroundColor: MyColors.SecondaryBlue,
                child: CustomText(
                  text: widget.userData!.name!.substring(0, 2).toUpperCase(),
                  fontSize: 26,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            CustomText(
              text: widget.userData!.name!,
              color: MyColors.gray,
              fontSize: 25,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              height: 2,
              width: utils.SizeConfig.blockSizeHorizontal * 95,
              decoration: BoxDecoration(
                border: Border.all(color: MyColors.SecondaryBlue, width: 2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}