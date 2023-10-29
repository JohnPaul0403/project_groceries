import 'package:app/global/enviroments.dart';
import 'package:app/helpers/app_colors.dart';
import 'package:app/pages/page_404.dart';
import 'package:app/services/status_service.dart';
import 'package:flutter/material.dart';
import 'package:app/utils/size_config.dart' as utils;
import 'package:async/async.dart';
import 'package:async/async.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({super.key});

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  late AsyncMemoizer asyncMemoizer;

  @override
  void initState() {
    asyncMemoizer = AsyncMemoizer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    utils.SizeConfig().init(context);
    return Scaffold(
      backgroundColor: MyColors.white,
      body: FutureBuilder(
        future: initApp(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: utils.SizeConfig.blockSizeHorizontal * 10.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // SizedBox(
                      //   width: utils.SizeConfig.blockSizeHorizontal * 65.0,
                      //   child: Image(
                      //     image: AssetImage(
                      //       'assets/png/LOGO-UNANDES-claro_vertical.png',
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        width: utils.SizeConfig.blockSizeHorizontal * 50.0,
                        child: const Image(
                          image: AssetImage(
                            'assets/png/JL_LOGO_primary.PNG',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Cash & Practicity',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: MyColors.SecondaryBlue,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  initApp() async {
    //Variable declaration
    print("het");
    var resp = await getStatusService();
    print("hello");
    var token = Environment.userToken;

    if (resp["status"] == false) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => Page404Page(
            sms: resp["message"],
          ),
        ),
        (Route<dynamic> route) => false,
      );
    } else {
      print("yes");
      return asyncMemoizer.runOnce(
        () {
          String? page;
          var appVersion = resp["app_version"];

          if (appVersion == Environment.version_app) {
            if (token != "token") {
              page = 'home_page';
            } else {
              page = 'login_page';
            }
          } else {
            page = 'update_page';
          }
          
          Future.delayed(const Duration(seconds: 1), () async {
            Navigator.pushReplacementNamed(context, page!);
          });
        },
      );
    }
  }
}