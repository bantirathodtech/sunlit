// import 'package:intl/intl.dart';
//
// class DateTimeUtils {
//   // Formats a DateTime object to a human-readable string
//   static String formatDateTime(DateTime dateTime,
//       {String format = 'yyyy-MM-dd HH:mm:ss'}) {
//     final DateFormat dateFormat = DateFormat(format);
//     return dateFormat.format(dateTime);
//   }
//
//   // Parses a date string into a DateTime object
//   static DateTime parseDateTime(String dateString,
//       {String format = 'yyyy-MM-dd HH:mm:ss'}) {
//     final DateFormat dateFormat = DateFormat(format);
//     return dateFormat.parse(dateString);
//   }
//
//   // Returns the difference in days between two DateTime objects
//   static int daysBetween(DateTime startDate, DateTime endDate) {
//     return endDate.difference(startDate).inDays;
//   }
//
//   // Adds days to a DateTime object and returns the new DateTime
//   static DateTime addDays(DateTime dateTime, int days) {
//     return dateTime.add(Duration(days: days));
//   }
//
//   // Subtracts days from a DateTime object and returns the new DateTime
//   static DateTime subtractDays(DateTime dateTime, int days) {
//     return dateTime.subtract(Duration(days: days));
//   }
//
//   // Checks if a given date is today
//   static bool isToday(DateTime dateTime) {
//     final now = DateTime.now();
//     return dateTime.year == now.year &&
//         dateTime.month == now.month &&
//         dateTime.day == now.day;
//   }
//
//   // Formats a DateTime object to a time string (e.g., 14:30)
//   static String formatTime(DateTime dateTime, {String format = 'HH:mm'}) {
//     final DateFormat timeFormat = DateFormat(format);
//     return timeFormat.format(dateTime);
//   }
//
//   // Converts a DateTime object to a human-readable relative time string (e.g., 2 hours ago)
//   static String timeAgo(DateTime dateTime) {
//     final Duration diff = DateTime.now().difference(dateTime);
//     if (diff.inDays > 7) {
//       return DateFormat('yyyy-MM-dd').format(dateTime);
//     } else if (diff.inDays >= 1) {
//       return '${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago';
//     } else if (diff.inHours >= 1) {
//       return '${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago';
//     } else if (diff.inMinutes >= 1) {
//       return '${diff.inMinutes} minute${diff.inMinutes > 1 ? 's' : ''} ago';
//     } else {
//       return 'Just now';
//     }
//   }
//
//   // Add this method specifically for your collection tab format
//   static String formatCollectionDateTime(DateTime dateTime) {
//     final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
//     final amPm = dateTime.hour >= 12 ? 'PM' : 'AM';
//     return '${dateTime.year}-'
//         '${dateTime.month.toString().padLeft(2, '0')}-'
//         '${dateTime.day.toString().padLeft(2, '0')} '
//         '${hour.toString().padLeft(2, '0')}:'
//         '${dateTime.minute.toString().padLeft(2, '0')} '
//         '$amPm';
//   }
//
//   // Converts a DateTime object to an ISO8601 string
//   static String toIsoString(DateTime dateTime) {
//     return dateTime.toIso8601String();
//   }
//
//   // Parses an ISO8601 string into a DateTime object
//   static DateTime fromIsoString(String isoString) {
//     return DateTime.parse(isoString);
//   }
// }
// //Purpose: Offers utilities for formatting and manipulating date and time values.
// // Usage: Used whenever you need to format, compare, or manipulate dates and times.
