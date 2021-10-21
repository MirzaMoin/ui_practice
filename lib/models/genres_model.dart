class GenresModel {
  int? categoryId;
  String? name;
  String? icon;

  GenresModel({this.categoryId, this.name, this.icon});

  GenresModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    name = json['name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['icon'] = this.icon;
    return data;
  }
}
