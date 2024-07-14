class CarouselModel {
  final String image;
  final String label;

  CarouselModel({
    required this.image,
    required this.label,
  });

  // Factory method to create a CarouselModel from a map
  factory CarouselModel.fromMap(Map<String, dynamic> map) {
    return CarouselModel(
      image: map['image'] as String,
      label: map['label'] as String,
    );
  }
}
