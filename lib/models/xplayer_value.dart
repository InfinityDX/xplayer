import 'dart:convert';

class XPlayerValue {
  final int? positon;
  final int? bufferedPosition;
  final double? playbackSpeed;
  final List<Quality>? qualities;

  const XPlayerValue({
    this.positon,
    this.bufferedPosition,
    this.playbackSpeed,
    this.qualities,
  });

  XPlayerValue copyWith({
    int? positon,
    int? bufferedPosition,
    double? playbackSpeed,
    List<Quality>? qualities,
  }) =>
      XPlayerValue(
        positon: positon ?? this.positon,
        bufferedPosition: bufferedPosition ?? this.bufferedPosition,
        playbackSpeed: playbackSpeed ?? this.playbackSpeed,
        qualities: qualities ?? this.qualities,
      );

  factory XPlayerValue.fromJson(String str) =>
      XPlayerValue.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory XPlayerValue.fromMap(Map<String, dynamic> json) => XPlayerValue(
        positon: json["positon"],
        bufferedPosition: json["bufferedPosition"],
        playbackSpeed: json["playbackSpeed"]?.toDouble(),
        qualities: json["qualities"] == null
            ? []
            : List<Quality>.from(
                json["qualities"]!.map((x) => Quality.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "positon": positon,
        "bufferedPosition": bufferedPosition,
        "playbackSpeed": playbackSpeed,
        "qualities": qualities == null
            ? []
            : List<dynamic>.from(qualities!.map((x) => x.toMap())),
      };
}

class Quality {
  final int? width;
  final int? height;

  Quality({
    this.width,
    this.height,
  });

  Quality copyWith({
    int? width,
    int? height,
  }) =>
      Quality(
        width: width ?? this.width,
        height: height ?? this.height,
      );

  factory Quality.fromJson(String str) => Quality.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Quality.fromMap(Map<String, dynamic> json) => Quality(
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toMap() => {
        "width": width,
        "height": height,
      };
}
