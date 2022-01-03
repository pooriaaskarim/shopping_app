import 'package:shopping_app/src/pages/shared/models/tag/tag_dto.dart';

class AdminAddProductTagDTO extends TagDTO {
  AdminAddProductTagDTO({required tag}) : super(tag: tag);

  Map<String, dynamic> toMap() {
    return {
      'tag': tag,
    };
  }

  factory AdminAddProductTagDTO.fromMap(Map<String, dynamic> map) {
    return AdminAddProductTagDTO(
      tag: map['tag'] as String,
    );
  }
}
