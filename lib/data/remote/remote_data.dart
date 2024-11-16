import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:penny_track/data/dto/accounts/auth.dart';
import 'package:penny_track/utils/environment.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

abstract class RemoteDataSource {
  // ///records
  // Future<List<Record>> getRecords();
  // Future<List<Record>> getRecordsByDate({required String date});
  // Future<int> manageRecord({required Record record, required Crud flag});

  // ///accounts
  // Future<List<Account>> getAccounts();
  // Future<List<Account>> getCalculatedAccounts();
  // Future<int> manageAccount({required Account account, required Crud flag});

  Future<Auth> getAuthCode();
  Future<void> getTokenCode({required Auth auth});
}

class RemoteData implements RemoteDataSource {
  @override
  Future<Auth> getAuthCode() async {
    try {
      final authorizationEndPoint = Uri.https(
        "api-uat.unionbankph.com",
        "/partners/sb/customers/v1/oauth2/authorize",
        {
          "client_id": Environment.clientId,
          "response_type": "code",
          "scope": "account_transactions",
          "redirect_uri": "https://api-uat.unionbankph.com/ubp/uat/v1/redirect",
          "type": "single"
        },
      );
      final tokenEndPoint = Uri.parse(
          "https://api-uat.unionbankph.com/partners/sb/customers/v1/oauth2/token");

      final redirectUrl =
          Uri.parse("https://api-uat.unionbankph.com/ubp/uat/v1/redirect");

      var grant = oauth2.AuthorizationCodeGrant(
        Environment.clientId,
        authorizationEndPoint,
        tokenEndPoint,
        secret: Environment.clientSecret,
        basicAuth: false,
      );

      var authorizationUrl = grant
          .getAuthorizationUrl(redirectUrl, scopes: ["account_transactions"]);

      print('auth ur;>>>$authorizationUrl');

      return Auth(
          grant: grant,
          authorizationUrl: authorizationUrl,
          redirectUrl: redirectUrl);

      // var url = Uri.https(
      //   "api-uat.unionbankph.com",
      //   "/partners/sb/convergent/v1/oauth2/authorize",
      //   {
      //     "client_id": Environment.clientId,
      //     "response_type": "code",
      //     "scope": "account_transactions",
      //     // "redirect_uri": "https://api-uat.unionbankph.com/ubp/uat/v1/redirect",
      //     // "type": "single"
      //   },
      // );

      // print(url);

      // var response = await http.get(url, headers: {
      //   "x-ibm-client-id": Environment.clientId,
      //   "x-ibm-client-secret": Environment.clientSecret
      // });

      // print(response.body);
    } catch (e) {
      print(e);
      return Auth(errorMessage: e.toString());
    }
  }

  @override
  Future<void> getTokenCode({required Auth auth}) async {
    try {
      // print("qweqweqwe>>>>${auth.grant}");
      // print("qweqweqwe>>>>${auth.redirectUrl}");
      Uri uri = Uri.https(
          "api-uat.unionbankph.com", "/partners/sb/customers/v1/oauth2/token", {
        "code": auth.redirectUrl!.queryParameters["code"],
        "client_id": Environment.clientId,
        "grant_type": "authorization_code",
        "redirect_uri": "https://api-uat.unionbankph.com/ubp/uat/v1/redirect"
      });

      final res = await http.post(
        Uri.parse(
            "https://api-uat.unionbankph.com/partners/sb/customers/v1/oauth2/token"),
        body: {
          "code": auth.redirectUrl!.queryParameters["code"],
          "client_id": Environment.clientId,
          "grant_type": "authorization_code",
          "redirect_uri": "https://api-uat.unionbankph.com/ubp/uat/v1/redirect",
        },
      );

      print("body boidy>>>>${res.body}");
      // print("qweqweqwe>>>>${uri.queryParameters}");
      // final result =
      //     await auth.grant!.handleAuthorizationResponse(uri.queryParameters);

      // print("sa wakaas may token na potang ina mo>>>>>$result");
    } catch (e) {
      print("tang ina error nanaman>>>$e");
    }
  }
}
