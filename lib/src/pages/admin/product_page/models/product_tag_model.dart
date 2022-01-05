import 'package:shopping_app/src/pages/shared/models/tag/tag_model.dart';

class AdminProductTagModel extends TagModel {
  AdminProductTagModel({required id, required tag}) : super(id: id, tag: tag);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tag': tag,
    };
  }

  factory AdminProductTagModel.fromMap(Map<String, dynamic> map) {
    return AdminProductTagModel(
      id: map['id'],
      tag: map['tag'],
    );
  }
}
