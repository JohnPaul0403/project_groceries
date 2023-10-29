import 'dart:convert';

class User {
  String? email;
  List<Item>? items;
  String? name;
  String? password;
  String? token;
  String? username;

  User({
    this.email,
    this.items,
    this.name,
    this.password,
    this.token,
    this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    List<dynamic>? itemsList = json['items'];
    List<Item>? items = itemsList?.map((item) => Item.fromJson(item)).toList();

    return User(
      email: json['email'] ?? "",
      items: items ?? [],
      name: json['name'] ?? "",
      password: json['password'] ?? "",
      token: json['tokken'] ?? "",
      username: json['username'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'items': items?.map((item) => item.toJson()).toList(),
      'name': name,
      'password': password,
      'token': token,
      'username': username,
    };
  }
}

class Item {
  String? amount;
  String? name;
  String? price;

  Item({
    this.amount,
    this.name,
    this.price,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      amount: json['amount'],
      name: json['name'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'name': name,
      'price': price,
    };
  }
}
