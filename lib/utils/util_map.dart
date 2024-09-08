String formatDistance(int distanceInMeters) {
  if (distanceInMeters < 1000) {
    return '${distanceInMeters}m';
  } else {
    double distanceInKm = distanceInMeters / 1000;
    if ((distanceInKm * 10) % 10 == 0) {
      return '${distanceInKm.toInt()}km';
    }
    return '${distanceInKm.toStringAsFixed(1)}km';
  }
}

String formatTime(int minute) {
  String time = '';
  if (minute ~/ 60 > 0) {
    time += '${minute ~/ 60}h ';
  }
  time += '${minute % 60}m';
  return time;
}

String formatTimeKor(int minute) {
  String time = '';
  if (minute ~/ 60 > 0) {
    time += '${minute ~/ 60}시간 ';
  }
  time += '${minute % 60}분';
  return time;
}
