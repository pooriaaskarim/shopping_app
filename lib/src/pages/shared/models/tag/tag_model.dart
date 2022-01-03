class TagModel {
  int id;
  String tag;

  TagModel({
    required this.id,
    required this.tag,
  });

  @override
  String toString() {
    return '''TagModel{
    id: $id,
    tag: $tag
    }''';
  }

// Map<String, dynamic> toMap() {
  //   return {
  //     'id': this.id,
  //     'tag': this.tag,
  //   };
  // }
  //
  // factory TagModel.fromMap(Map<String, dynamic> map) {
  //   return TagModel(
  //     id: map['id'] as String,
  //     tag: map['tag'] as String,
  //   );
  // }
}
