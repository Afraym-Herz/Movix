import 'dart:async';

bool _isThrottled = false;
Timer? _throttleTimer;

void onScroll(double offset) {
  // 1. If we are currently in a cooldown, do nothing
  if (_isThrottled) return;

  // 2. Execute the action immediately (Leading edge)
  _isThrottled = true;
  // 3. Set a timer to reset the flag after the duration
  _throttleTimer = Timer(const Duration(milliseconds: 500), () {
    _isThrottled = false;
  });
}

@override
void dispose() {
  _throttleTimer?.cancel(); // Always clean up!
 
}