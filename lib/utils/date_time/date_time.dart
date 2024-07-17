import 'dart:math';

DateTime parseDateTime(String dateString, String timeString) {
  // Parse date from yyyy-mm-dd format string
  List<int> dateParts = dateString.split('-').map(int.parse).toList();
  int year = dateParts[0];
  int month = dateParts[1];
  int day = dateParts[2];

  // Parse time from HH:MM AM/PM format string
  List<String> timeParts = timeString.split(' ');
  List<int> timeNumbers = timeParts[0].split(':').map(int.parse).toList();
  int hour = timeNumbers[0];
  int minute = timeNumbers[1];
  bool isPM = timeParts[1] == 'PM';

  // Adjust hour for PM times (12-hour to 24-hour format)
  if (isPM && hour < 12) {
    hour += 12;
  } else if (!isPM && hour == 12) {
    hour = 0; // Handle 12 AM case
  }

  // Create DateTime object by combining date and time
  DateTime dateTime = DateTime(year, month, day, hour, minute);

  return dateTime;
}

String getMonthName(int month) {
  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  return months[month - 1];
}

String formatDateTime(DateTime dateTime) {
  // Extract components
  int hour = dateTime.hour;
  int minute = dateTime.minute;
  String period = hour >= 12 ? 'PM' : 'AM';

  // Convert hour from 24-hour to 12-hour format
  if (hour > 12) {
    hour -= 12;
  } else if (hour == 0) {
    hour = 12;
  }

  // Format time
  String formattedTime =
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';

  // Extract and format date components
  String day = dateTime.day.toString().padLeft(2, '0');
  String month = getMonthName(dateTime.month);
  String year = dateTime.year.toString();

  // Combine into final format
  String formattedDate = '$day-$month-$year';
  return '$formattedTime - $formattedDate';
}

String generateFileName([String? identifier]) {
  // Extract the original file extension
  // String fileExtension = originalFilePath.split('.').last;
  // Generate a timestamp
  DateTime now = DateTime.now();
  String timestamp =
      '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}';

  // Generate a random unique identifier
  String uniqueId = Random().nextInt(100000).toString().padLeft(5, '0');

  // Combine to create a versatile file name
  String fileName = '${identifier ?? 'file'}_${timestamp}_$uniqueId';

  return fileName;
}
