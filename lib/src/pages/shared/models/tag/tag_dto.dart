class TagDTO {
  String tag;

  TagDTO({
    required this.tag,
  });

  Map<String, dynamic> toMap() {
    return {
      'tag': tag,
    };
  }

  factory TagDTO.fromMap(Map<String, dynamic> map) {
    return TagDTO(
      tag: map['tag'],
    );
  }
}
