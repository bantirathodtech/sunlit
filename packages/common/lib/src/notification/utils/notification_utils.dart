//
// import 'package:common/common_widgets.dart';
//
// DiscountNotificationModel getDiscountNotification(var notificationData){
//   DiscountNotificationModel discountNotificationModel = DiscountNotificationModel();
//   var jsonResponse = json.decode(notificationData);
//   discountNotificationModel.id = jsonResponse["data"]["_id"];
//   discountNotificationModel.source = jsonResponse["data"]["source"];
//   discountNotificationModel.orderId = jsonResponse["data"]["orderId"];
//   discountNotificationModel.orderDate = jsonResponse["data"]["orderDate"];
//   discountNotificationModel.orderTime = jsonResponse["data"]["orderTime"];
//   discountNotificationModel.userId = jsonResponse["data"]["userId"];
//   discountNotificationModel.username = jsonResponse["data"]["username"];
//   discountNotificationModel.storeId = jsonResponse["data"]["storeId"];
//   discountNotificationModel.customerName = jsonResponse["data"]["customerName"];
//   discountNotificationModel.customerId = jsonResponse["data"]["customerId"];
//   discountNotificationModel.customerEmail = jsonResponse["data"]["customerEmail"];
//   discountNotificationModel.customerAddress = jsonResponse["data"]["customerAddress"];
//   discountNotificationModel.customerMobile = jsonResponse["data"]["customerMobile"];
//   discountNotificationModel.transactionDate = jsonResponse["data"]["transactionDate"];
//   discountNotificationModel.transactionNumber = jsonResponse["data"]["transactionNumber"];
//   discountNotificationModel.discountAmount = jsonResponse["data"]["discountAmount"];
//   discountNotificationModel.discountPercentage = jsonResponse["data"]["discountPercentage"];
//   discountNotificationModel.reasonForDiscount = jsonResponse["data"]["reasonForDiscount"];
//   discountNotificationModel.applicableItems = jsonResponse["data"]["applicableItems"];
//   discountNotificationModel.managerName = jsonResponse["data"]["managerName"];
//   discountNotificationModel.notes = jsonResponse["data"]["notes"];
//   discountNotificationModel.attachments = jsonResponse["data"]["attachments"];
//   discountNotificationModel.title = jsonResponse["notification"]["title"];
//   discountNotificationModel.text = jsonResponse["notification"]["text"];
//   discountNotificationModel.body = jsonResponse["notification"]["body"];
//   discountNotificationModel.status = jsonResponse["data"]["status"];
//
//   return discountNotificationModel;
// }
