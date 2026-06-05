class ApiService {
  // Android emulator: 10.0.2.2 maps to your computer's localhost.
  // Physical device on same WiFi: replace with your PC's local IP, e.g. 192.168.1.5
static const String baseUrl = 'http://localhost:3000';
  static Map<String, String> get headers => {
        'Content-Type': 'application/json',
      };

  // Records fetched from the API get prefixed IDs:
  //   complaints → "c_1", "c_2", ...
  //   leaves     → "l_1", "l_2", ...
  static String? parseApiId(String historyId) {
    final parts = historyId.split('_');
    return parts.length == 2 ? parts[1] : null;
  }

  static bool isComplaintRecord(String id) => id.startsWith('c_');
  static bool isLeaveRecord(String id)     => id.startsWith('l_');

  // Returns true for any record that was fetched from the backend
  static bool isApiRecord(String id) =>
      isComplaintRecord(id) || isLeaveRecord(id);
}
