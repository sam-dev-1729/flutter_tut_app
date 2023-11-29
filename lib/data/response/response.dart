import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "countOfNotification")
  int? countOfNotification;

  CustomerResponse(this.id, this.name, this.countOfNotification);
  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContentResponse {
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "link")
  String? link;
  @JsonKey(name: "phone")
  String? phone;

  ContentResponse(this.phone, this.email, this.link);
  factory ContentResponse.fromJson(Map<String, dynamic> json) =>
      _$ContentResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ContentResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "content")
  ContentResponse? content;
  @JsonKey(name: "customer")
  CustomerResponse? customer;

  AuthenticationResponse(this.customer, this.content);

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}
