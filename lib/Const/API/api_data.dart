library api_data;

String domain = '192.168.1.161:8000';

Map<String, String> register = const {
  '/register': '/api/register',
  '/update-device-token': 'api/update-device-token',
  '/send-notification': 'api/send-notification',
  '/verify-otp': '/api/verify-otp',
};

Map<String, String> auth = const {
  '/login': '/api/login',
  '/logout': '/api/logout',
};

Map<String, String> user = const {
  '/transactions': '/api/v1/transactions',
  '/updatePatch': '/api/v1/users/',
};
