class ResponseModel {
  int? statusCode;
  String? statusMessage;
  Map<String, dynamic>? responseData;

  ResponseModel({this.statusCode, this.responseData, this.statusMessage});

  ResponseModel.fromJson(json)
      : statusCode = json['statusCode'] as int,
        statusMessage = json['statusMessage'] as String,
        responseData = json['responseData'];
}
