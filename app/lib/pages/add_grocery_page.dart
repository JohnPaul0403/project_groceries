import 'package:app/helpers/app_colors.dart';
import 'package:app/services/add_product_service.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/utils/size_config.dart' as utils;
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AddGroceryPage extends StatefulWidget {
  const AddGroceryPage({super.key});

  @override
  State<AddGroceryPage> createState() => _AddGroceryPageState();
}

class _AddGroceryPageState extends State<AddGroceryPage> {
  GlobalKey<FormState>? formKey;
  GlobalKey<ScaffoldState>? scaffoldKey;
  TextEditingController? name;
  TextEditingController? price;
  TextEditingController? amount;
  bool isLoading = false;

  @override
  void initState() {
    formKey = new GlobalKey();
    scaffoldKey = new GlobalKey();
    name = TextEditingController(
        text: 'oreo',
        );
    price = TextEditingController(
        text: '2000',
        );
    amount = TextEditingController(
        text: '2',
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: MyColors.white,
      appBar: navBar("Add purchase"),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                CustomText(
                  text: "Add your purchase information",
                  color: MyColors.SecondaryBlue,
                  fontSize: 20,
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              height: 2,
              width: utils.SizeConfig.blockSizeHorizontal * 95,
              decoration: BoxDecoration(
                border: Border.all(color: MyColors.SecondaryBlue, width: 2),
              ),
            ),
            textSection(),
            buttonSection()
          ],
        ),
      ),
    );
  }

  addProduct() async {
    if (name!.text.isEmpty) {
      setState(() {
        isLoading = false;
      });
      print("name is empty") ;
      return;
    }

    if (price!.text.isEmpty) {
      setState(() {
        isLoading = false;
      });
      print("price is empty") ;
      return;
    }

    if (amount!.text.isEmpty) {
      setState(() {
        isLoading = false;
      });
      print("amount is empty") ;
      return;
    }

    if (name!.text.isNotEmpty && amount!.text.isNotEmpty) {
      var res = await addProductService(name!.text, price!.text, amount!.text);
      if (res["status"] == true) {
        setState(() {
          isLoading = false;
        });

        print(res["resp"]);
        return;
      } else {
        setState(() {
          isLoading = false;
        });

        print(res["message"]);
        return;
      }
    } else {
      setState(() {
        isLoading = false;
      });

      print("Conection error");
      return;
    }
  }

  Widget textSection() {
    return Container(
      color: MyColors.white,
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            controller: name,
            cursorColor: MyColors.darkModeBlack,
            style: TextStyle(
              color: MyColors.darkModeBlack,
            ),
           
            decoration: InputDecoration(
              icon: Icon(
                Icons.contact_page,
                color: MyColors.SecondaryBlue,
              ),
              fillColor: MyColors.darkModeBlack,
              hintText: "Name",
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
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
            controller: price,
            cursorColor: MyColors.SecondaryBlue,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: MyColors.darkModeBlack,
            ),
            decoration: InputDecoration(
              fillColor: MyColors.darkModeBlack,
              icon: Icon(
                Icons.wallet_giftcard,
                color: MyColors.SecondaryBlue,
              ),
              hintText: "Price",
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
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
            controller: amount,
            cursorColor: MyColors.SecondaryBlue,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: MyColors.darkModeBlack,
            ),
            decoration: InputDecoration(
              fillColor: MyColors.darkModeBlack,
              icon: Icon(
                Icons.sell,
                color: MyColors.SecondaryBlue,
              ),
              hintText: "Amount",
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
          const SizedBox(
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
          addProduct();
        },
        child: const CustomText(
          text: 'Add purchase',
        ),
      ),
    );
  }
}