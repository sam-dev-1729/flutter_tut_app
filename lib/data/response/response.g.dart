// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse()
  ..status = json['status'] as int?
  ..message = json['message'] as String?;

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

CustomerResponse _$CustomerResponseFromJson(Map<String, dynamic> json) =>
    CustomerResponse(
      json['id'] as String?,
      json['name'] as String?,
      json['countOfNotification'] as int?,
    );

Map<String, dynamic> _$CustomerResponseToJson(CustomerResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'countOfNotification': instance.countOfNotification,
    };

ContentResponse _$ContentResponseFromJson(Map<String, dynamic> json) =>
    ContentResponse(
      json['phone'] as String?,
      json['email'] as String?,
      json['link'] as String?,
    );

Map<String, dynamic> _$ContentResponseToJson(ContentResponse instance) =>
    <String, dynamic>{
      'email': instance.email,
      'link': instance.link,
      'phone': instance.phone,
    };

AuthenticationResponse _$AuthenticationResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticationResponse(
      json['customer'] == null
          ? null
          : CustomerResponse.fromJson(json['customer'] as Map<String, dynamic>),
      json['content'] == null
          ? null
          : ContentResponse.fromJson(
              Map<String, String>.from(json['content'] as Map)),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AuthenticationResponseToJson(
        AuthenticationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'content': instance.content,
      'customer': instance.customer,
    };
