import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:moallim_mate/data/app_exceptions.dart';
import 'package:moallim_mate/data/network/base_api_services.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(Duration(seconds: 10));

      responseJson = await returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      case 400:
        final decodedJson = json.decode(response.body);
        throw BadRequestException(decodedJson['message'] ?? '');

      case 404:
        throw UnauthorizedException(response.body.toString());
      default:
        throw FetchDataException('Something went wrong...');
    }
  }
}
