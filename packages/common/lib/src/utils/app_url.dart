//endpoints urls for the endpoints

import 'package:flutter/material.dart';

// Base URL for the API
String baseURL = "https://hub.sunlit.noton.dev/";

// URL for image uploads
const String imageURL = "https://sapp.mycw.in/image-manager/uploadImage";

// Key for image uploads
const String imageUploadKey = "AUa4koVlpsgR7PZwPVhRdTfUvYsWcjkg";

// Authentication URL
String plgAuthUrl =
    "https://services.sunlit.noton.dev/core-services/auth/signin";

// GraphQL URL for retail services
const String plgGraphQlUrl =
    "https://services.sunlit.noton.dev/retail-services/graphql";

// GraphQL URL for core services
String plgCoreGraphQlUrl =
    "https://services.sunlit.noton.dev/core-services/graphql";

// Global BuildContext
late BuildContext buildContext;

// static void setURL(int environment) {
//   switch (environment) {
//     case 0: // Production
//       baseURL = 'https://api.example.com';
//       break;
//     case 1: // Staging
//       baseURL = 'https://staging-api.example.com';
//       break;
//     case 2: // Development
//       baseURL = 'https://dev-api.example.com';
//       break;
//   }
//   plgAuthUrl = 'https://services.sunlit.noton.dev/core-services/auth/signin';
//   plgCoreGraphQlUrl = 'https://services.sunlit.noton.dev/core-services/graphql';
// }

void setURL(int type) {
  if (type == 0) {
    baseURL = "https://hub.sunlit.noton.dev/";
  } else {
    baseURL = "https://hub.sunlit.noton.dev/";
  }
}

//Users
//cw - cw@erp =   75AC553F342F44C999A2471285ED6ABA
//chandu - Exceloid@123  =  D80ACE70072B4C0BA9286097072F5A18
//sudheer - Exceloid@123 = C39BE37A53B34F2C859A49784AEE07AE

// flutter clean
// flutter build apk --release
// flutter install
