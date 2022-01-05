import 'package:shopping_app/src/pages/shared/models/tag/tag_dto.dart';

class AdminProductTagDTO extends TagDTO {
  AdminProductTagDTO({required tag}) : super(tag: tag);

  Map<String, dynamic> toMap() {
    return {
      'tag': tag,
    };
  }

  factory AdminProductTagDTO.fromMap(Map<String, dynamic> map) {
    return AdminProductTagDTO(
      tag: map['tag'],
    );
  }
}
