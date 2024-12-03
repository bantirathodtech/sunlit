// lib/common/feature_flags/feature_flags.dart

class FeatureFlags {
  // A map to store feature flags
  final Map<String, bool> _flags = {};

  // Singleton instance
  static final FeatureFlags _instance = FeatureFlags._internal();

  // Factory constructor for singleton pattern
  factory FeatureFlags() => _instance;

  // Private constructor
  FeatureFlags._internal();

  // Method to set a feature flag
  void setFeatureFlag(String feature, bool isEnabled) {
    _flags[feature] = isEnabled;
  }

  // Method to check if a feature is enabled
  bool isFeatureEnabled(String feature) {
    return _flags[feature] ?? false;
  }

  // Example: Initialize feature flags from a config or remote source
  void initializeFlags(Map<String, bool> initialFlags) {
    _flags.addAll(initialFlags);
  }
}
//Purpose: Implements feature toggles to enable or disable features dynamically.
// Usage: Used to manage and toggle features without needing a full app deployment.
