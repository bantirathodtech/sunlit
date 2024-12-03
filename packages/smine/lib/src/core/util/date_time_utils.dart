import 'package:intl/intl.dart';

class DateTimeUtils {
  static const String customFormat = 'yyyy:MM:dd hh:mm a'; // UI desired format
  static const String graphQLFormat = 'yyyy-MM-dd HH:mm:ss'; // GraphQL format

  // Converts a DateTime object to a string formatted for display in the UI.
  static String formatForDisplay(DateTime dateTime) {
    final formatter = DateFormat(customFormat);
    return formatter.format(dateTime);
  }

  // Converts a date string in UI format to GraphQL format.
  static String formatForGraphQL(String formattedDate) {
    final formatter = DateFormat(customFormat);
    final dateTime = formatter.parse(formattedDate);
    return DateFormat(graphQLFormat).format(dateTime);
  }

  // Parses a date string into a DateTime object using a specified format.
  static DateTime parseDateTime(String dateString,
      {String format = graphQLFormat}) {
    final DateFormat dateFormat = DateFormat(format);
    return dateFormat.parse(dateString);
  }

  // Checks if a given date string is valid according to a specified format.
  static bool isValidDateFormat(String date, {String format = customFormat}) {
    try {
      DateFormat(format).parse(date);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Formats a DateTime object to a time string (e.g., 14:30)
  static String formatTime(DateTime dateTime, {String format = 'HH:mm'}) {
    final DateFormat timeFormat = DateFormat(format);
    return timeFormat.format(dateTime);
  }

  // Returns the difference in days between two DateTime objects
  static int daysBetween(DateTime startDate, DateTime endDate) {
    return endDate.difference(startDate).inDays;
  }

  // Adds days to a DateTime object and returns the new DateTime
  static DateTime addDays(DateTime dateTime, int days) {
    return dateTime.add(Duration(days: days));
  }

  // Subtracts days from a DateTime object and returns the new DateTime
  static DateTime subtractDays(DateTime dateTime, int days) {
    return dateTime.subtract(Duration(days: days));
  }

  // Checks if a given date is today
  static bool isToday(DateTime dateTime) {
    final now = DateTime.now();
    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }

  // Converts a DateTime object to a human-readable relative time string (e.g., 2 hours ago)
  static String timeAgo(DateTime dateTime) {
    final Duration diff = DateTime.now().difference(dateTime);
    if (diff.inDays > 7) {
      return DateFormat('yyyy-MM-dd').format(dateTime);
    } else if (diff.inDays >= 1) {
      return '${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} minute${diff.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }
}

// Purpose: Offers utilities for formatting and manipulating date and time values.
// Usage: Used whenever you need to format, compare, or manipulate dates and times.
