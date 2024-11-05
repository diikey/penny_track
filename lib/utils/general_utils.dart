import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Crud { create, read, update, delete }

class GeneralUtils {
  ///convert string date to another string format
  static String convertDateString(
      {required String input, required String format}) {
    DateTime dateTime = DateTime.parse(input);

    String formattedDate = DateFormat(format).format(dateTime);
    return formattedDate;
  }

  ///convert date time to string</br>
  ///samples ["yyyy-MM-dd HH:mm:ss", "MMM yyyy", "MMM dd, yyyy"]
  static String convertDateTime(
      {required DateTime dateTime, required String format}) {
    String formattedDate = DateFormat(format).format(dateTime);
    return formattedDate;
  }

  ///convert double to money with money sign.
  ///possible to add variable to cater different countries
  static String convertDoubleToMoney({required double amount}) {
    // Create a NumberFormat for currency
    final currencyFormat = NumberFormat.currency(
      locale: 'en_PH', // Locale for Philippine Peso
      symbol: '₱', // Currency symbol
      decimalDigits: 2, // Number of decimal places
    );

    // Format the amount
    String formattedAmount = currencyFormat.format(amount);

    return formattedAmount;
  }

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}
