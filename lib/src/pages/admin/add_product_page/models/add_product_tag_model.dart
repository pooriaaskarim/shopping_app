import 'package:shopping_app/src/pages/shared/models/tag/tag_model.dart';

class AdminAddProductTagModel extends TagModel {
  AdminAddProductTagModel({required id, required tag})
      : super(id: id, tag: tag);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tag': tag,
    };
  }

  factory AdminAddProductTagModel.fromMap(Map<String, dynamic> map) {
    return AdminAddProductTagModel(
      id: map['id'] as int,
      tag: map['tag'] as String,
    );
  }
}
