// import 'package:dio/dio.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:shatably_app/core/helpers/constant/constant.dart';
// import 'package:shatably_app/core/services/api/api_consumer.dart';
// import 'package:shatably_app/feature/booking%20process/data/models/ephemeral_key_model/ephemeral_key_model.dart';
// import 'package:shatably_app/feature/booking%20process/data/models/init_payment_sheet_input_model.dart';
// import 'package:shatably_app/feature/booking%20process/data/models/payment_intent_input_model.dart';
// import 'package:shatably_app/feature/booking%20process/data/models/payment_intent_model/payment_intent_model.dart';

// class StripeService {
//   final ApiConsumer apiConsumer;

//   StripeService(this.apiConsumer);
//   //  stripe    دي لازم تتعمل واول خطوه في ال
//   Future<PaymentIntentModel> createPaymentIntent(
//     PaymentIntentInputModel paymentIntentInputModel,
//   ) async {
//     var response = await apiConsumer.post(
//       "https://api.stripe.com/v1/payment_intents",
//       data: paymentIntentInputModel.toJson(),
//       options: Options(
//         contentType: Headers.formUrlEncodedContentType,
//         headers: {'Authorization': "Bearer ${Constants.secretKey}"},
//       ),
//     );

//     var paymentIntentModel = PaymentIntentModel.fromJson(response.data);

//     return paymentIntentModel;
//   }

//   Future initPaymentSheet({
//     required InitiPaymentSheetInputModel initiPaymentSheetInputModel,
//   }) async {
//     await Stripe.instance.initPaymentSheet(
//       paymentSheetParameters: SetupPaymentSheetParameters(
//         paymentIntentClientSecret: initiPaymentSheetInputModel.clientSecret,
//         customerEphemeralKeySecret:
//             initiPaymentSheetInputModel.ephemeralKeySecret,
//         customerId: initiPaymentSheetInputModel.customerId,
//         merchantDisplayName: 'Mohamed',
//       ),
//     );
//   }

//   Future displayPaymentSheet() async {
//     //  presentPaymentSheet ده اللي هيظهر ال
//     await Stripe.instance.presentPaymentSheet();
//   }

//   Future makePayment(
//   //  مع بعض impelement  الميثود دي متقسمه ل ثلاث اقسام بس احنا جمعناهم هنا علشان يعملهوا
//   //  createPaymentIntent   docs    الخطوه الاولي ودي موجوده في ال
//   {required PaymentIntentInputModel paymentIntentInputModel}) async {
//     var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);

//     // ما كل شويه يدخل بيانات البطاقه بدل علشان لو المستخدم حب يحفظ بياناته علشان لو هيعمل عمليه دفع تانيه  ephemeralKey  الخطوه الثانيه هي نعمل
//     var ephemeralKeyModel =
//     // customer كل  الخاص ب  id   هنبعت ال
//     await createEphemeralKey(customerId: paymentIntentInputModel.cusomerId);

//     //  paymentIntentInputModel   هو طالبها زي ال  body بيانات في ال  request  علشان نعمل عمليه الدفع لازم نبعت مع ال
//     //  ephemeralKeySecret  و clientSecret  انما الاضافي هو ال
//     // ephemeralKeyModel ودي علشان ال
//     var initPaymentSheetInputModel = InitiPaymentSheetInputModel(
//       clientSecret: paymentIntentModel.clientSecret!,
//       customerId: paymentIntentInputModel.cusomerId,
//       ephemeralKeySecret: ephemeralKeyModel.secret!,
//     );

//     await initPaymentSheet(
//       initiPaymentSheetInputModel: initPaymentSheetInputModel,
//     );

//     //  stripe  الخاص ب ال  sheet  هنظهر ال
//     await displayPaymentSheet();
//   }

//   // createEphemeralKey  هنعمل ال
//   Future<EphemeralKeyModel> createEphemeralKey({
//     required String customerId,
//   }) async {
//     var response = await apiConsumer.post(
//       "https://api.stripe.com/v1/payment_intents",

//       data: {'customer': customerId},
//       options: Options(
//         contentType: Headers.formUrlEncodedContentType,
//         headers: {
//           'Authorization': "Bearer ${Constants.secretKey}",
//           'Stripe-Version': '2025-6-16',
//         },
//       ),

//       // postman ودي اكتشفتها من ال  Version header  طلب مننا نحط في ال  stripe    علشان هو في ال  headers  عملنا
//     );

//     var ephermeralKey = EphemeralKeyModel.fromJson(response.data);

//     return ephermeralKey;
//   }
// }
