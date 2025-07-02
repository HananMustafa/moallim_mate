class Endpoint {
  // static var baseUrl = 'http://127.0.0.1:8000/api/';
  // static var baseUrl = 'http://10.0.2.2:8000/api/'; //for android emulator
  // static var baseUrl = 'http://172.17.241.29:8000/api/'; //for physical device
  static var baseUrl =
      'https://laravel-backend-rq3p.onrender.com/api/'; //backend on render

  static var loginEndpoint = '${baseUrl}login';
  static var getEventsEndpoint = '${baseUrl}getEvents';
}
