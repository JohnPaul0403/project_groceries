import 'package:app/helpers/app_colors.dart';
import 'package:app/pages/add_grocery_page.dart';
import 'package:app/pages/groceries_page.dart';
import 'package:app/pages/settings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:app/utils/size_config.dart' as utils;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Widget> _widgetOptions = <Widget>[
    GroceriesPage(),
    AddGroceryPage(),
    SettingsPage(),
  ];
  int _selectedIndex = 0;

  List<BottomNavigationBarItem> itemsNavBart() {
    return [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.home_outlined,
          size: utils.SizeConfig.blockSizeVertical * 4,
          color: MyColors.gray,
        ),
        label: "Home",
        activeIcon: Icon(
          Icons.home,
          size: utils.SizeConfig.blockSizeVertical * 3,
        ),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.add_circle_outline,
          size: utils.SizeConfig.blockSizeVertical * 4,
          color: MyColors.gray,
        ),
        label: "",
        activeIcon: Icon(
          Icons.add_circle,
          size: utils.SizeConfig.blockSizeVertical * 4,
        ),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.more_horiz_outlined,
          size: utils.SizeConfig.blockSizeVertical * 4,
          color: MyColors.gray,
        ),
        label: "More",
        activeIcon: Icon(
          Icons.more_horiz,
          size: utils.SizeConfig.blockSizeVertical * 3,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _widgetOptions,
        ),
        bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        useLegacyColorScheme: false,
        showUnselectedLabels: true,
        backgroundColor: MyColors.white,
        items: itemsNavBart(),
        currentIndex: _selectedIndex,
        selectedItemColor: MyColors.SecondaryBlue,
        unselectedLabelStyle: TextStyle(color: MyColors.white),
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      ), 
      onWillPop: () async {
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
          return false;
        }

        return true;
      },
    );
  }
}