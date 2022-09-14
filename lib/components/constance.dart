import 'package:flutter/material.dart';
import 'package:shopping_app/Modules/login/login_screen.dart';

const defaultColor = Colors.blue;

String token = '';

void signOut(context) =>
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => ShopLoginScreen(),), (
        route) => false);
