class EpisodeModel {
  int? episodeId;
  int? episodeNo;
  int? seasonNo;
  String? episodeName;
  String? videoUrl;
  String? thumbImage;
  int? watched;

  EpisodeModel(
      {this.episodeId,
      this.episodeNo,
      this.seasonNo,
      this.episodeName,
      this.videoUrl,
      this.thumbImage,
      this.watched});

  EpisodeModel.fromJson(Map<String, dynamic> json) {
    episodeId = json['episode_id'];
    episodeNo = json['episode_no'];
    seasonNo = json['season_no'];
    episodeName = json['episode_name'];
    videoUrl = json['video_url'];
    thumbImage = json['thumb_image'];
    watched = json['watched'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['episode_id'] = this.episodeId;
    data['episode_no'] = this.episodeNo;
    data['season_no'] = this.seasonNo;
    data['episode_name'] = this.episodeName;
    data['video_url'] = this.videoUrl;
    data['thumb_image'] = this.thumbImage;
    data['watched'] = this.watched;
    return data;
  }
}
