import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// Custom cache manager for managing file cache
class CustomCacheManager {
  static final CustomCacheManager _instance = CustomCacheManager._internal();

  factory CustomCacheManager() => _instance;

  CustomCacheManager._internal();

  final CacheManager _cacheManager = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: Duration(days: 7), // Duration to keep the cache
      maxNrOfCacheObjects: 100, // Maximum number of objects to cache
      repo: JsonCacheInfoRepository(databaseName: 'custom_cache'),
      fileService: HttpFileService(),
    ),
  );

  // Method to get cached file
  Future<File> getFile(String url) async {
    final file = await _cacheManager.getSingleFile(url);
    return file;
  }

  // Method to download and cache file
  Future<FileInfo> downloadFile(String url) async {
    final file = await _cacheManager.downloadFile(url);
    return file;
  }

  // Method to clear all cache
  Future<void> clearCache() async {
    await _cacheManager.emptyCache();
  }
}

// Custom cache manager for images
class CustomImageCacheManager {
  static final CustomImageCacheManager _instance =
      CustomImageCacheManager._internal();

  factory CustomImageCacheManager() => _instance;

  CustomImageCacheManager._internal();

  final CacheManager _imageCacheManager = CacheManager(
    Config(
      'customImageCacheKey',
      stalePeriod: Duration(days: 7), // Duration to keep the image cache
      maxNrOfCacheObjects: 100, // Maximum number of images to cache
      repo: JsonCacheInfoRepository(databaseName: 'custom_image_cache'),
      fileService: HttpFileService(),
    ),
  );

  // Method to get cached image
  Future<File> getImage(String url) async {
    final file = await _imageCacheManager.getSingleFile(url);
    return file;
  }

  // Method to download and cache image
  Future<FileInfo> downloadImage(String url) async {
    final file = await _imageCacheManager.downloadFile(url);
    return file;
  }

  // Method to clear image cache
  Future<void> clearImageCache() async {
    await _imageCacheManager.emptyCache();
  }
}
//Purpose: Manages caching of data and images to improve performance and reduce network calls.
// Usage: Used to cache data and images for better performance and offline support.
