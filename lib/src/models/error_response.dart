///The model class for error of APIs in [lib/utils.dart].
class ErrorResponse {
  int code;
  String error;

  ErrorResponse({this.code, this.error});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        code: json['code'],
        error: json['error'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': code,
        'error': error,
      };
}
