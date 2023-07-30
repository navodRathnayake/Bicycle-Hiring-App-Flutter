library api_data;

String domain = '192.168.1.161:8000';

Map<String, String> register = const {
  '/register': '/api/register',
  '/update-device-token': '/update-device-token',
  '/send-notification': '/send-notification',
  '/verify-otp': '/verify-otp',
};

Map<String, String> auth = const {
  '/login': '/api/login',
  '/logout': '/api/logout',
};
