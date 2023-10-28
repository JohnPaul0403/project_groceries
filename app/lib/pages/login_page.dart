import 'package:app/global/enviroments.dart';
import 'package:app/helpers/app_colors.dart';
import 'package:app/models/login_model.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/services/login_service.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/utils/size_config.dart' as utils;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState>? formKey;
  GlobalKey<ScaffoldState>? scaffoldKey;
  TextEditingController? username;
  TextEditingController? password;
  late bool _passwordVisible;
  bool isLoading = false;

  @override
  void initState() {
    formKey = new GlobalKey();
    scaffoldKey = new GlobalKey();
    username = new TextEditingController(
        text: 'user_1',
        );
    password = new TextEditingController(
        text: 'password112',
    );
    //currentIndex = '2';
    _passwordVisible = true;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: SafeArea(
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: utils.SizeConfig.blockSizeHorizontal * 50.0,
                child: const Image(
                  image: AssetImage(
                    'assets/png/JL_LOGO_primary.PNG',
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              textSection(),
              isLoading? CircularProgressIndicator() : buttonSection(),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Don't have an account? Sign up",
                    color: MyColors.darkModeBlack,
                  ),
                  CupertinoButton(
                    child: CustomText(
                      text: "here",
                      color: MyColors.activeBlue,
                    ), 
                    onPressed: () {
                      Navigator.pushNamed(context, "signup_page");
                    }
                  )
                ],
              )
            ],
          ),
        )
      ),
    );
  }

  Future<void> getLogin() async {
    if (username!.text.isEmpty) {
      setState(() {
        isLoading = false;
      });
      print("username is empty") ;
      return;
    }

    if (password!.text.isEmpty) {
      setState(() {
        isLoading = false;
      });
      print("Password is empty");
      return;
    }

    if (username!.text.isNotEmpty && password!.text.isNotEmpty) {
      dynamic res = await loginService(username!.text, password!.text);
      if (res["status"] == true) {
        User user = res["resp"];
        Environment.userToken = user.token ?? "token";
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) {
              return HomePage();
            },
          ),
          (Route<dynamic> route) => false,
        );
      } else {
          setState(() {
          isLoading = false;
        });
        print(res["message"]);
      }
    } else {
      setState(() {
        isLoading = false;
      });

      print("Conection error");
      return;
    }
  }

  Container textSection() {
    return Container(
      color: MyColors.white,
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            controller: username,
            cursorColor: MyColors.darkModeBlack,
            style: TextStyle(
              color: MyColors.darkModeBlack,
            ),
           
            decoration: InputDecoration(
              icon: Icon(
                Icons.person,
                color: MyColors.SecondaryBlue,
              ),
              fillColor: MyColors.darkModeBlack,
              hintText: "Username",
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: MyColors.SecondaryBlue,
                ),
              ),
              hintStyle: TextStyle(
                color: MyColors.SecondaryBlue,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            autocorrect: false,
            enableSuggestions: false,
            obscureText: _passwordVisible,
            controller: password,
            cursorColor: MyColors.SecondaryBlue,
            keyboardType: TextInputType.visiblePassword,
            style: TextStyle(
              color: MyColors.darkModeBlack,
            ),
            decoration: InputDecoration(
              fillColor: MyColors.darkModeBlack,
              icon: Icon(
                Icons.lock,
                color: MyColors.SecondaryBlue,
              ),
              hintText: "password",
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: MyColors.SecondaryBlue,
                ),
              ),
              hintStyle: TextStyle(
                color: MyColors.SecondaryBlue,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: MyColors.gray,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(
                    () {
                      _passwordVisible = !_passwordVisible;
                    },
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: CupertinoButton(
        color: MyColors.blue,
        onPressed: () {
          setState(() {
            isLoading = true;
          });
          getLogin();
        },
        child: CustomText(
          text: 'Login',
        ),
      ),
    );
  }
}