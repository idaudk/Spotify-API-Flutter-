class SpotifyModel {
  String response;
  List<Content> content;

  SpotifyModel({required this.response, required this.content});

  factory SpotifyModel.fromJson(Map<String, dynamic> json) {
    var list = json['content'] as List;
    List<Content> contentList =
        list.map((content) => Content.fromJson(content)).toList();
    return SpotifyModel(response: json['response'], content: contentList);
  }
}

class Content {
  int position, streams;
  String track_title, track_url, track_id, thumbnail, trend;
  List<String> artists;

  Content(
      {required this.position,
      required this.track_title,
      required this.track_url,
      required this.track_id,
      required this.thumbnail,
      required this.trend,
      required this.streams,
      required this.artists});

  factory Content.fromJson(Map<String, dynamic> json) {
    var artistsFromJson = json['artists'];
    List<String> artistsList = artistsFromJson.cast<String>();
    return Content(
        position: json['position'],
        track_title: json['track_title'],
        track_url: json['track_url'],
        track_id: json['track_id'],
        thumbnail: json['thumbnail'],
        trend: json['trend'],
        streams: json['streams'],
        artists: artistsList,
        );
  }
}
