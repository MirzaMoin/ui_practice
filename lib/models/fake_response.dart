class Response {
  int id;
  String name;
  String imageUrl;
  bool isFavourite;

  Response(this.id, this.name, this.imageUrl, {this.isFavourite = false});
}

class Categories {
  String name;
  String icon;

  Categories(this.name, this.icon);
}

final CategoriesList = [
  Categories("Horror", "๐ฑ"),
  Categories("Romantic", "๐ฅฐ"),
  Categories("Comedy", "๐"),
  Categories("Drama", "๐คฉ"),
  Categories("Action", "๐"),
  Categories("Adventure", "๐ค"),
  Categories("Biography", "โน๏ธโโ๏ธ"),
  Categories("Crime", "๐ช"),
  Categories("Family", "๐จโ๐ฉโ๐งโ๐ฆ"),
  Categories("Thriller", "๐ฒ"),
  Categories("Sci-Fi", "๐ฝ"),
  Categories("Sport", "๐๏ธโโ๏ธ"),
];
final ResponseDataList = [
  Response(0, "GOLD",
      "https://static.tvmaze.com/uploads/images/original_untouched/84/211238.jpg"),
  Response(1, "Gold Rush",
      "https://static.tvmaze.com/uploads/images/original_untouched/244/610985.jpg"),
  Response(2, "Attic Gold",
      "https://static.tvmaze.com/uploads/images/original_untouched/16/41290.jpg"),
  Response(3, "White Gold",
      "https://static.tvmaze.com/uploads/images/original_untouched/113/283528.jpg"),
  Response(4, "Backroad Gold",
      "https://static.tvmaze.com/uploads/images/original_untouched/93/233881.jpg"),
  Response(5, "Gold Digger",
      "https://static.tvmaze.com/uploads/images/original_untouched/218/546082.jpg"),
  Response(6, "Yukon Gold",
      "https://static.tvmaze.com/uploads/images/original_untouched/20/51711.jpg"),
  Response(7, "Hitler's Gold",
      "https://static.tvmaze.com/uploads/images/original_untouched/279/698792.jpg"),
  Response(8, "Gold Town",
      "https://static.tvmaze.com/uploads/images/original_untouched/300/750242.jpg"),
];
