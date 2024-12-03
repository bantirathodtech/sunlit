// // lib/common/config/app_config.dart
// /// Manages global configuration settings like base URLs and environment variables.
// enum Environment { development, staging, production }
//
// /// A class that manages global configuration settings for the app.
// class AppConfig {
//   // Base URL for the API
//   final String apiUrl;
//
//   // URL for image uploads
//   final String imageUrl;
//
//   // Key for image uploads
//   final String imageUploadKey;
//
//   // Authentication URL
//   final String authUrl;
//
//   // GraphQL URL for retail services
//   final String retailGraphQlUrl;
//
//   // GraphQL URL for core services
//   final String coreGraphQlUrl;
//
//   // Environment type (e.g., development, staging, production)
//   final Environment environment;
//
//   // Constructor
//   AppConfig({
//     required this.apiUrl,
//     required this.imageUrl,
//     required this.imageUploadKey,
//     required this.authUrl,
//     required this.retailGraphQlUrl,
//     required this.coreGraphQlUrl,
//     required this.environment,
//   });
//
//   // Factory method to create an AppConfig instance based on the environment
//   factory AppConfig.fromEnvironment(Environment env) {
//     switch (env) {
//       case Environment.production:
//         return AppConfig(
//           apiUrl: 'https://api.production.example.com/',
//           imageUrl: 'https://api.production.example.com/images',
//           imageUploadKey: 'prod-image-key',
//           authUrl: 'https://api.production.example.com/auth',
//           retailGraphQlUrl: 'https://api.production.example.com/graphql/retail',
//           coreGraphQlUrl: 'https://api.production.example.com/graphql/core',
//           environment: Environment.production,
//         );
//       case Environment.staging:
//         return AppConfig(
//           apiUrl: 'https://api.staging.example.com/',
//           imageUrl: 'https://api.staging.example.com/images',
//           imageUploadKey: 'staging-image-key',
//           authUrl: 'https://api.staging.example.com/auth',
//           retailGraphQlUrl: 'https://api.staging.example.com/graphql/retail',
//           coreGraphQlUrl: 'https://api.staging.example.com/graphql/core',
//           environment: Environment.staging,
//         );
//       case Environment.development:
//       default:
//         return AppConfig(
//           apiUrl: 'https://hub.sunlit.noton.dev/',
//           imageUrl: 'https://sapp.mycw.in/image-manager/uploadImage',
//           imageUploadKey: 'AUa4koVlpsgR7PZwPVhRdTfUvYsWcjkg',
//           authUrl:
//               'https://services.sunlit.noton.dev/core-services/auth/signin',
//           retailGraphQlUrl:
//               'https://services.sunlit.noton.dev/retail-services/graphql',
//           coreGraphQlUrl:
//               'https://services.sunlit.noton.dev/core-services/graphql',
//           environment: Environment.development,
//         );
//     }
//   }
// }
// //Purpose: Manages global configuration settings like base URLs and environment variables.
// // Usage: Used to centralize and manage different configuration settings for your application environments (development, staging, production).
