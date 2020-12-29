///The model class for [fetchAllThreads] and [fetchSpecThread].
class ThreadResponse {
  List<Thread> results;

  ThreadResponse({this.results});

  factory ThreadResponse.fromJson(Map<String, dynamic> json) => ThreadResponse(
        results: (json['results'] as List)
            .map((e) =>
                e == null ? null : Thread.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'results': results,
      };
}

///The model class for [getAllThread] and [getThreadInfo] API.
class Thread {
  String updatedAt;
  String content;
  String uid;
  String objectId;
  String createdAt;
  String status;
  String deviceType;
  String contact;

  Thread(
      {this.updatedAt,
      this.content,
      this.uid,
      this.objectId,
      this.createdAt,
      this.status,
      this.deviceType,
      this.contact});

  factory Thread.fromJson(Map<String, dynamic> json) => Thread(
        updatedAt: json['updatedAt'] as String,
        content: json['content'] as String,
        uid: json['uid'] as String,
        objectId: json['objectId'] as String,
        createdAt: json['createdAt'] as String,
        status: json['status'] as String,
        deviceType: json['deviceType'] as String,
        contact: json['contact'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'updatedAt': updatedAt,
        'content': content,
        'uid': uid,
        'objectId': objectId,
        'createdAt': createdAt,
        'status': status,
        'deviceType': deviceType,
        'contact': contact,
      };
}
