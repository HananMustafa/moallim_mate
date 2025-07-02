import 'package:moallim_mate/data/network/BaseApiServices.dart';
import 'package:moallim_mate/data/network/NetworkApiServices.dart';
import 'package:moallim_mate/res/endpoints.dart';

class ConnectMoellimRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> connectMoellim(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
        endpoint.loginEndpoint,
        data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getEvents(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
        endpoint.getEventsEndpoint,
        data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
