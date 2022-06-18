import 'dart:convert';

ErrorResponse errorResponseFromJson(String str) => ErrorResponse.fromJson(json.decode(str));

class ErrorResponse {
  String? message;
  String? documentationUrl;

  ErrorResponse({this.message, this.documentationUrl});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    documentationUrl = json['documentation_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['documentation_url'] = documentationUrl;
    return data;
  }
}
