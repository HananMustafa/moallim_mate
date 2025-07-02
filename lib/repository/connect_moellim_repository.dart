import 'package:moallim_mate/data/network/base_api_services.dart';
import 'package:moallim_mate/data/network/network_api_services.dart';
import 'package:moallim_mate/res/endpoints.dart';

class ConnectMoellimRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> connectMoellim(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
        Endpoint.loginEndpoint,
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
        Endpoint.getEventsEndpoint,
        data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
