// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class XPlayerValue {
  final int? playerState;
  final int? position;
  final int? bufferedPosition;
  final double? playbackSpeed;
  final List<Quality>? qualities;

  const XPlayerValue({
    this.playerState = 1,
    this.position = 0,
    this.bufferedPosition = 0,
    this.playbackSpeed = 0,
    this.qualities = const [],
  });

  factory XPlayerValue.fromJson(String str) =>
      XPlayerValue.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory XPlayerValue.fromMap(Map<String, dynamic> json) => XPlayerValue(
        playerState: json["playerState"],
        position: json["position"],
        bufferedPosition: json["bufferedPosition"],
        playbackSpeed: json["playbackSpeed"]?.toDouble(),
        qualities: json["qualities"] == null
            ? []
            : List<Quality>.from(
                json["qualities"]!.map((x) => Quality.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "playerState": playerState,
        "position": position,
        "bufferedPosition": bufferedPosition,
        "playbackSpeed": playbackSpeed,
        "qualities": qualities == null
            ? []
            : List<dynamic>.from(qualities!.map((x) => x.toMap())),
      };

  XPlayerValue copyWith(XPlayerValue value) {
    return XPlayerValue(
      playerState: value.playerState ?? playerState,
      position: value.position ?? position,
      bufferedPosition: value.bufferedPosition ?? bufferedPosition,
      playbackSpeed: value.playbackSpeed ?? playbackSpeed,
      qualities: value.qualities ?? qualities,
    );
  }
}

class Quality {
  final int? width;
  final int? height;

  Quality({
    this.width,
    this.height,
  });

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
