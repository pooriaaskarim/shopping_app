import 'package:shopping_app/shopping_app.dart';

class RepositoryUrls {
  static String fullBaseUrl = ShoppingAppParameters.fullBaseUrl;
  static String users() => '$fullBaseUrl/users';
  static String userImages() => '$fullBaseUrl/user_images';
  static String userById(int userID) => '$fullBaseUrl/users/$userID';
  static String userImageById(int imageID) =>
      '$fullBaseUrl/user_images/$imageID';

  static String products() => '$fullBaseUrl/products';
  static String productById(int productID) =>
      '$fullBaseUrl/products/$productID';
  static String productTags() => '$fullBaseUrl/product_tags';
  static String productTagByID(int tagID) => '$fullBaseUrl/product_tags/$tagID';
  static String productImages() => '$fullBaseUrl/product_images';
  static String productImageById(int imageID) =>
      '$fullBaseUrl/product_images/$imageID';
}
