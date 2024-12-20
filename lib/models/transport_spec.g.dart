// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transport_spec.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransportSpecImpl _$$TransportSpecImplFromJson(Map<String, dynamic> json) =>
    _$TransportSpecImpl(
      id: json['id'] as String,
      specNumber: json['specNumber'] as String,
      loadingDate: DateTime.parse(json['loadingDate'] as String),
      loadingLocation: json['loadingLocation'] as String,
      unloadingDate: DateTime.parse(json['unloadingDate'] as String),
      unloadingLocation: json['unloadingLocation'] as String,
      rate: (json['rate'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$$TransportSpecImplToJson(_$TransportSpecImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'specNumber': instance.specNumber,
      'loadingDate': instance.loadingDate.toIso8601String(),
      'loadingLocation': instance.loadingLocation,
      'unloadingDate': instance.unloadingDate.toIso8601String(),
      'unloadingLocation': instance.unloadingLocation,
      'rate': instance.rate,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'userId': instance.userId,
    };
