import 'package:app/global/enviroments.dart';
import 'package:app/helpers/app_colors.dart';
import 'package:app/models/login_model.dart';
import 'package:app/services/userDataService.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroceriesPage extends StatefulWidget {
  const GroceriesPage({super.key});

  @override
  State<GroceriesPage> createState() => _GroceriesPageState();
}

class _GroceriesPageState extends State<GroceriesPage> {
  GlobalKey<ScaffoldState>? scaffoldKey;
  var _userData;
  bool _error = false;
  bool _isLoading = true;

  @override
  void initState() {
    scaffoldKey = new GlobalKey();
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
      appBar: navBar("Home"),
      body: _isLoading? const CircularProgressIndicator() 
      : (_error) ? Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Icon(
                Icons.exit_to_app, 
                color: MyColors.gray,
                size: 100,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: CustomText(
                text: "Your session has expired!",
                color: MyColors.SecondaryBlue,
                fontSize: 22,
              )
            ),
            const SizedBox(
              height: 20,
            ),
            CupertinoButton(
              color: MyColors.SecondaryBlue,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context, 
                  "launch_page", 
                  (route) => false
                );
              },
              child: const CustomText(
                text: "Login",
                fontSize: 20,
              ),
            ),
          ],
        ),
      ) : 
      (_userData.items!.isEmpty)? Container(
        child: Column(
          children: [
            Icon(Icons.signal_cellular_null_rounded, color: MyColors.SecondaryBlue,)
          ]
        ),
      ) : SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                CustomText(
                  text: "Your purchases",
                  color: MyColors.blue,
                  fontSize: 20,
                ),
              ]
            ),
            const SizedBox(
              height: 10,
            ),
          ] + _userData.items!.reversed.map<Widget>(
            (e) => groceryWidget(e)
          ).toList(),
        ),
      ),
    );
  }

  Widget groceryWidget (Item grocery) {
    int total = int.parse(grocery.price!) * int.parse(grocery.amount!);
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
      decoration: BoxDecoration(
        color: MyColors.inactiveWhite,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: grocery.name!,
            color: MyColors.SecondaryBlue,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  CustomText(
                    text: "Price: ",
                    color: MyColors.SecondaryBlue,
                  ),
                  CustomText(
                    text: grocery.price!,
                    color: MyColors.SecondaryBlue,
                  )
                ],
              ),
              Row(
                children: [
                  CustomText(
                    text: "Amount: ",
                    color: MyColors.SecondaryBlue,
                  ),
                  CustomText(
                    text: grocery.amount!,
                    color: MyColors.SecondaryBlue,
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                height: 2,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: MyColors.SecondaryBlue, 
                    width: 2)
                  ),
              ),
              Row(
                children: [
                  CustomText(
                    text: "total: ",
                    color: MyColors.SecondaryBlue,
                  ),
                  CustomText(
                    text: total.toString(),
                    color: MyColors.SecondaryBlue,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}