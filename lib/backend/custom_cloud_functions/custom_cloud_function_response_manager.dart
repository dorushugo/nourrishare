import '/backend/schema/structs/index.dart';

class StripeWebhookCloudFunctionCallResponse {
  StripeWebhookCloudFunctionCallResponse({
    this.errorCode,
    this.succeeded,
    this.jsonBody,
  });
  String? errorCode;
  bool? succeeded;
  dynamic jsonBody;
}
