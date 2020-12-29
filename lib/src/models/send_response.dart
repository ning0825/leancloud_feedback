///The model class for [createFeedback], [userAppendMessage] and [devAppendMessage] API.
class SendResponse {
  final String objectId;
  final String createdAt;

  SendResponse({this.objectId, this.createdAt});

  factory SendResponse.fromJson(Map<String, dynamic> json) => SendResponse(
        objectId: json['objectId'],
        createdAt: json['createdAt'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'objectId': this.objectId,
        'createdAt': this.createdAt,
      };
}
