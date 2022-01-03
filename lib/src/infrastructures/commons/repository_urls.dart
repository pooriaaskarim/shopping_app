import 'package:shopping_app/shopping_app.dart';

class RepositoryUrls {
  static String fullBaseUrl = ShoppingAppParameters.fullBaseUrl;
  static String users() => '$fullBaseUrl/users';
  static String userImages() => '$fullBaseUrl/user_images';
  static String userById(final int id) => '$fullBaseUrl/users/$id';
  static String userImageById(final int imageID) =>
      '$fullBaseUrl/user_images/$imageID';

  static String products() => '$fullBaseUrl/products';
  static String productById(final int id) => '$fullBaseUrl/products/$id';
  static String productTags() => '$fullBaseUrl/product_tags';
  static String productTagByID(final int tagID) =>
      '$fullBaseUrl/product_tags/$tagID';
  static String productImages() => '$fullBaseUrl/product_images';
  static String productImageById(final int imageID) =>
      '$fullBaseUrl/product_images/$imageID';
}
