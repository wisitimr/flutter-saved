class AccessToken {
  final String accessToken;

  AccessToken({
    required this.accessToken,
  });

  factory AccessToken.fromJson(Map<String, dynamic> json) => AccessToken(
        accessToken: json['accessToken'],
      );
}
