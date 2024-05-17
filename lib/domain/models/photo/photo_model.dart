import 'package:freezed_annotation/freezed_annotation.dart';
part 'photo_model.freezed.dart';
part 'photo_model.g.dart';

@freezed
class Photo with _$Photo {
  const Photo._(); // * For custom methods
  // * @JsonSerializable(explicitToJson: true) - for nested Model !!!
  const factory Photo({
    required int id,
    @Default('600x600') String title,
    required String url,
  }) = _Photo;

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  String photoInfo() => url;
}
