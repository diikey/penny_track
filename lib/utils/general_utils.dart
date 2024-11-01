import 'package:intl/intl.dart';

enum Crud { create, read, update, delete }

class GeneralUtils {
  ///convert string date to MMM dd, yyyy format
  static String convertDateString({required String input}) {
    DateTime dateTime = DateTime.parse(input);

    String formattedDate = DateFormat("MMM dd, yyyy").format(dateTime);
    return formattedDate;
  }

  ///convert date time now to yyyy-MM-dd HH:mm:ss
  static String convertDateTime({required DateTime dateTime}) {
    String formattedDate = DateFormat("yyyy-MM-dd HH:mm:ss").format(dateTime);
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
}
