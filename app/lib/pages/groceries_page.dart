import 'package:app/global/enviroments.dart';
import 'package:app/helpers/app_colors.dart';
import 'package:app/models/login_model.dart';
import 'package:app/services/userDataService.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class GroceriesPage extends StatefulWidget {
  const GroceriesPage({super.key});

  @override
  State<GroceriesPage> createState() => _GroceriesPageState();
}

class _GroceriesPageState extends State<GroceriesPage> {
  GlobalKey<ScaffoldState>? scaffoldKey;
  late User _userData;
  late bool _error;
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
      body: (_error) ? Container(
        child: Center(
          child: CustomText(
            text: "Your session has expired",
          ),
        ),
      ) : 
      (_userData.items!.isEmpty)? Container(
        child: Column(
          children: []
        ),
      ) : SingleChildScrollView(
        child: Column(
          children: _userData.items!.map<Widget>(
            (e) => groceryWidget(e)
          ).toList(),
        ),
      ),
    );
  }

  Widget groceryWidget (Item grocery) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: MyColors.inactiveWhite,
        borderRadius: BorderRadius.circular(30)
      ),
      child: Row(
        children: [
          CustomText(
            text: grocery.name!,
            color: MyColors.SecondaryBlue,
          )
        ],
      ),
    );
  }
}