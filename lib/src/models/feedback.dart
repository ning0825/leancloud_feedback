///Used by [ConversationResponse].
class Feedback {
  String type;
  String className;
  String objectId;

  Feedback({this.type, this.className, this.objectId});

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
        type: json['type'] as String,
        className: json['className'] as String,
        objectId: json['objectId'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': type,
        'className': className,
        'objectId': objectId,
      };
}
