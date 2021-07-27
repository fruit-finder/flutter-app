class Fruit {
  final String pred_name;
  final String actual_name;
  var cons;
  var pros;
  final String description;
  final String url;

  Fruit({
    required this.pred_name,
    required this.actual_name,
    required this.cons,
    required this.pros,
    required this.description,
    required this.url,
  });

  String getName() {
    return this.actual_name;
  }

  String toString() {
    return this.pred_name;
  }

  factory Fruit.fromJson(Map<String, dynamic> json) {
    List fruit_names = json.keys.toList();
    return Fruit(
      pred_name: fruit_names[0],
      actual_name: fruit_names[0]['name'],
      cons: json[fruit_names[0]['cons']],
      pros: json[fruit_names[0]['pros']],
      url: json[fruit_names[0]['image_url']],
      description: json[fruit_names[0]['description']],
    );
  }
}
