class CastModel {
  int? cast_id;
  final String? name, imageUrl;

  CastModel(this.name, this.imageUrl, this.cast_id);

  CastModel.fromJson(Map<String, dynamic> json)
      : cast_id = json.containsKey('cast_id')
            ? json['cast_id'] != null
                ? json['cast_id']
                : 0
            : 0,
        name = json.containsKey('name')
            ? json['name'] != null
                ? json['name']
                : ""
            : "",
        imageUrl = json.containsKey('image_url')
            ? json['image_url'] != null
                ? json['image_url']
                : ""
            : "";
}
