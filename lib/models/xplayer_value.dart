import 'dart:convert';

class XPlayerValue {
  final int? positon;
  final int? bufferedPosition;
  final double? playbackSpeed;

  const XPlayerValue({
    this.positon,
    this.bufferedPosition,
    this.playbackSpeed,
  });

  XPlayerValue copyWith({
    int? positon,
    int? bufferedPosition,
    double? playbackSpeed,
  }) =>
      XPlayerValue(
        positon: positon ?? this.positon,
        bufferedPosition: bufferedPosition ?? this.bufferedPosition,
        playbackSpeed: playbackSpeed ?? this.playbackSpeed,
      );

  factory XPlayerValue.fromJson(String str) =>
      XPlayerValue.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory XPlayerValue.fromMap(Map<String, dynamic> json) => XPlayerValue(
        positon: json["positon"],
        bufferedPosition: json["bufferedPosition"],
        playbackSpeed: json["playbackSpeed"],
      );

  Map<String, dynamic> toMap() => {
        "positon": positon,
        "bufferedPosition": bufferedPosition,
        "playbackSpeed": playbackSpeed,
      };
}
