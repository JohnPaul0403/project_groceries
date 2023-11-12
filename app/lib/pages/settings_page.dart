import 'package:app/global/enviroments.dart';
import 'package:app/helpers/app_colors.dart';
import 'package:app/pages/profile_page.dart';
import 'package:app/services/userDataService.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/utils/size_config.dart' as utils;

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  GlobalKey<ScaffoldState>? scaffoldKey;
  var _userData;
  bool _error = false;
  bool _isLoading = true;

  @override
  void initState() {
    initData();
    super.initState();
  }

  Future<dynamic> initData() async {
    var res = await userDataService(Environment.userToken);
    if (res["status"] == true) {
      setState(() {
        _userData = res["resp"];
        _error = false;
        _isLoading = false;
      });
    } else {
      setState(() {
        _error = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: MyColors.white,
      appBar: navBar("Settings"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (BuildContext context) => ProfilePage(userData: _userData,)
                  )
                );
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                decoration: BoxDecoration(
                  color: MyColors.inactiveWhite,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        CircleAvatar(
                          maxRadius: 26,
                          backgroundColor: MyColors.SecondaryBlue,
                          child: CustomText(
                            text: "${_userData.name!.substring(0, 2).toUpperCase()}",
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        CustomText(
                          text: _userData!.name,
                          color: MyColors.SecondaryBlue,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    Icon(
                      Icons.keyboard_arrow_right_outlined,
                      color: MyColors.gray,
                      size: 30.0,
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              height: 2,
              width: utils.SizeConfig.blockSizeHorizontal * 95,
              decoration: BoxDecoration(
                border: Border.all(color: MyColors.SecondaryBlue, width: 2),
              ),
            ),
            columnButton(
              context,
              'Contact Us',
              "contact_page",
              CupertinoIcons.chat_bubble_fill,
              Colors.green,
            ),
            columnButton(
              context,
              'Terms and Conditions',
              "contact_page",
              Icons.perm_device_information_sharp,
              Colors.amber,
            ),
            columnButton(
              context,
              'About the app',
              "contact_page",
              Icons.pageview_outlined,
              MyColors.black,
            ),
            const SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 140.0, right: 140.0),
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                color: const Color.fromARGB(255, 161, 27, 54),
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                child: const Center(
                  child: Text(
                    "Log Out",
                    style: TextStyle(
                      color: Color.fromARGB(255, 239, 239, 239),
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                onPressed: () => logOutAlert(),
              ),
            ),
            const SizedBox(
              height: 60.0,
            ),
          ],
        ),
      ),
    );
  }

  logOutAlert() {
    Environment.userToken = "token";
    Navigator.pushNamedAndRemoveUntil(context, "login_page", (route) => false);
  }

  columnButton(BuildContext context, String name, String page, dynamic icon,
      dynamic color) {
    return CupertinoButton(
      onPressed: () {
        Navigator.pushNamed(context, page);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 30.0,
              ),
              CustomText(
                textOverflow: TextOverflow.ellipsis,
                text: " $name",
                color: MyColors.gray,
              ),
            ],
          ),
          const Icon(
            Icons.keyboard_arrow_right_outlined,
            color: CupertinoColors.systemGrey,
            size: 30.0,
          ),
        ],
      ),
    );
  }
}