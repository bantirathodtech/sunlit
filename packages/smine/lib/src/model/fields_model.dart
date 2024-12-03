// filename: fields_model.dart

class FieldModel {
  final String columnName;
  final String tableName;
  final List<SearchData> searchData;

  FieldModel({
    required this.columnName,
    required this.tableName,
    required this.searchData,
  });

  factory FieldModel.fromJson(Map<String, dynamic> json) {
    var searchDataList = json['searchData'] as List;
    List<SearchData> searchData =
        searchDataList.map((i) => SearchData.fromJson(i)).toList();
    return FieldModel(
      columnName: json['ColumnName'],
      tableName: json['TableName'],
      searchData: searchData,
    );
  }
}

class SearchData {
  final String recordId;
  final String name;

  SearchData({required this.recordId, required this.name});

  factory SearchData.fromJson(Map<String, dynamic> json) {
    return SearchData(
      recordId: json['RecordID'],
      name: json['Name'],
    );
  }
}
