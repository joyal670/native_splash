DateTime loginClickTime = DateTime.now();
const Duration clickInterval = Duration(seconds: 2);

bool isRedundantClick(DateTime currentTime) {
  if (loginClickTime == null ||
      currentTime.difference(loginClickTime) >= clickInterval) {
    loginClickTime = currentTime;
    print("Click processed");
    return false;
  } else {
    print("Redundant click");
    return true;
  }
}

// bool isRedundantClick(DateTime currentTime) {
//   if (loginClickTime == null) {
//     loginClickTime = currentTime;
//     print("first click");
//     return false;
//   }
//   print('diff is ${currentTime.difference(loginClickTime).inSeconds}');
//   if (currentTime.difference(loginClickTime).inSeconds < 3) {
//     // set this difference time in seconds
//     return true;
//   }

//   loginClickTime = currentTime;
//   return false;
// }
