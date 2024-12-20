import 'package:freezed_annotation/freezed_annotation.dart';

part 'transport_spec.freezed.dart';
part 'transport_spec.g.dart';

@freezed
class TransportSpec with _$TransportSpec {
  const factory TransportSpec({
    required String id,
    required String specNumber,
    required DateTime loadingDate,
    required String loadingLocation,
    required DateTime unloadingDate,
    required String unloadingLocation,
    required double rate,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String userId,
  }) = _TransportSpec;

  factory TransportSpec.fromJson(Map<String, dynamic> json) =>
      _$TransportSpecFromJson(json);
}
