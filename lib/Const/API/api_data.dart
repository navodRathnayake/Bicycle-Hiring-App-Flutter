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
  '/recentActivity': '/api/v1/users/19/recent-activities',
  '/user': '/api/v1/users/',
};

Map<String, String> bicycle = const {
  '/bicycle': '/api/v1/bicycles/',
  '/patch': '/api/v1/bicycles'
};

Map<String, String> path = const {
  '/path': '/api/v1/paths',
};

Map<String, String> postRecentActivity = const {
  '/recent_activities': '/api/v1/recentactivities'
};

Map<String, String> patchRecentActivity = const {
  '/patch': '/api/v1/recentactivities/'
};
