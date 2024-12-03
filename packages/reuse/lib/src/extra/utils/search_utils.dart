// lib/common/utils/search_utils.dart

// Utility class for search and filtering operations
class SearchUtils {
  /// Filters a list of strings based on the search query.
  ///
  /// [dataList] - The list of strings to be filtered.
  /// [query] - The search query to filter the list by.
  ///
  /// Returns a list of filtered strings that match the search query.
  static List<String> filterStrings(List<String> dataList, String query) {
    if (query.isEmpty) {
      return dataList;
    }

    final lowerCaseQuery = query.toLowerCase();

    return dataList.where((item) {
      return item.toLowerCase().contains(lowerCaseQuery);
    }).toList();
  }

  /// Filters a list of objects based on a search query.
  ///
  /// [dataList] - The list of objects to be filtered.
  /// [query] - The search query to filter the list by.
  /// [getter] - A function to extract the string property to search within each object.
  ///
  /// Returns a list of filtered objects that match the search query.
  static List<T> filterObjects<T>(
    List<T> dataList,
    String query,
    String Function(T) getter,
  ) {
    if (query.isEmpty) {
      return dataList;
    }

    final lowerCaseQuery = query.toLowerCase();

    return dataList.where((item) {
      final itemString = getter(item).toLowerCase();
      return itemString.contains(lowerCaseQuery);
    }).toList();
  }

  /// Removes duplicates from a list.
  ///
  /// [list] - The list from which duplicates are to be removed.
  ///
  /// Returns a list with duplicates removed.
  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  /// Sorts a list of strings alphabetically.
  ///
  /// [list] - The list of strings to be sorted.
  ///
  /// Returns a sorted list of strings.
  static List<String> sortStrings(List<String> list) {
    list.sort();
    return list;
  }

  /// Searches within a list of objects based on a search query and returns
  /// the matching objects.
  ///
  /// [dataList] - The list of objects to be searched.
  /// [query] - The search query to search within the list.
  /// [getter] - A function to extract the string property to search within each object.
  ///
  /// Returns a list of objects that match the search query.
  static List<T> searchObjects<T>(
    List<T> dataList,
    String query,
    String Function(T) getter,
  ) {
    final filteredList = filterObjects(dataList, query, getter);
    return removeDuplicates(filteredList);
  }
}
//Purpose: Provides utilities for implementing search functionality and filtering data.
// Usage: Used to implement search and filtering features.
