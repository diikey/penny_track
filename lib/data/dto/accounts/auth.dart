import 'package:oauth2/oauth2.dart';

class Auth {
  final AuthorizationCodeGrant? grant;
  final Uri? authorizationUrl;
  final Uri? redirectUrl;
  final String? errorMessage;

  const Auth({
    this.grant,
    this.authorizationUrl,
    this.redirectUrl,
    this.errorMessage,
  });
}
