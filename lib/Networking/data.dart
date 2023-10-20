import 'package:json_annotation/json_annotation.dart';
part 'data.g.dart';

@JsonSerializable()
class Result {
  const Result({this.results});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  final List<Character>? results;

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class Character {
  const Character({this.id, this.name, this.species, this.image});

  factory Character.fromJson(Map<String, dynamic> json) => _$CharacterFromJson(json);

  final int? id;
  final String? name;
  final String? species;
  final String? image;

  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}