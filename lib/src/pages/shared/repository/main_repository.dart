import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class Client {
  Future<Either<Exception, Response>> dioGet(String url) async {
    try {
      var response = await Dio().get(url);
      if (responseIsSuccessful(response)) {
        return Right(response);
      } else {
        return Left(Exception(
            'dioGet: Connection Error: $url :: ${response.statusCode}'));
      }
    } on DioError catch (e) {
      return Left(Exception('dioGet: Connection Error: $e'));
    }
  }

  Future<Either<Exception, Response>> dioPost(String url, var jsonMap) async {
    try {
      var response = await Dio().post(
        url,
        data: jsonMap,
      );
      if (responseIsSuccessful(response)) {
        return Right(response);
      } else {
        return Left(Exception(
            'dioPost: Connection Error: $url :: ${response.statusCode}'));
      }
    } on DioError catch (e) {
      return Left(Exception('dioPost: Connection Error: $e'));
    }
  }

  Future<Either<Exception, Response>> dioPut(String url, var jsonMap) async {
    try {
      var response = await Dio().put(
        url,
        data: jsonMap,
      );
      if (responseIsSuccessful(response)) {
        return Right(response);
      } else {
        return Left(Exception(
            'dioPut: Connection Error: $url :: ${response.statusCode}'));
      }
    } on DioError catch (e) {
      return Left(Exception('dioPut: Connection Error: $e'));
    }
  }

  Future<Either<Exception, Response>> dioDelete(String url) async {
    try {
      var response = await Dio().delete(url);
      if (responseIsSuccessful(response)) {
        return Right(response);
      } else {
        return Left(Exception(
            'dioDelete: Connection Error: $url :: ${response.statusCode}'));
      }
    } on DioError catch (e) {
      return Left(Exception('dioDelete: Connection Error: $e'));
    }
  }

//   await dioPut(url, json);
  // }
  bool responseIsSuccessful(Response response) =>
      (response.statusCode! >= 200) && (response.statusCode! < 300);
}

void main() async {
  var client = Client();
  // Map<String, dynamic> m = {
  //   'name': 'Pooria',
  //   'surname': 'Askari',
  //   'username': 'pooria',
  //   'password': '1234',
  //   'address': 'adasdas',
  //   'isAdmin': true
  // };
  // await client.dioPost('http://127.0.0.1:3000/users', m);
  await client.dioDelete('http://127.0.0.1:3000/product_images/4');
  await client.dioDelete('http://127.0.0.1:3000/product_images/5');
  await client.dioDelete('http://127.0.0.1:3000/product_images/6');
  await client.dioDelete('http://127.0.0.1:3000/product_images/7');
}
