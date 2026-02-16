// 1. Declare the timer at the class level
import 'dart:async';
class Debouncer {
Timer? _debounceTimer;

 void onSearchChanged(String query) {
  // 2. If the user types again, cancel the previous timer
  if (_debounceTimer?.isActive ?? false) {
    _debounceTimer?.cancel();
  }

  // 3. Start a new timer for 500ms (or your preferred delay)
  _debounceTimer = Timer(const Duration(milliseconds: 500), () {
    // 4. This code only runs if 500ms pass without a new input
    _performSearch(query);
  });
}

void _performSearch(String query) {
  print('Searching for: $query');
  // Trigger your API Call or Filter logic here
}

void dispose() {
  // 5. Crucial: Always cancel the timer when the widget is destroyed
  _debounceTimer?.cancel();
}}