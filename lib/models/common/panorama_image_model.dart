class PanoramaImageModel {
  final String sceneName;
  final String imageURL;

  PanoramaImageModel({required this.sceneName, required this.imageURL});

  // Factory method to create a PanoramaImage from a map
  factory PanoramaImageModel.fromMap(Map<String, dynamic> map) {
    return PanoramaImageModel(
      sceneName: map['sceneName'] as String,
      imageURL: map['imageURL'] as String,
    );
  }

  // Method to convert a PanoramaImage to a map
  Map<String, dynamic> toMap() {
    return {
      'sceneName': sceneName,
      'imageURL': imageURL,
    };
  }
}
